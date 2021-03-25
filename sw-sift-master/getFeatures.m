% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ descrs, locs ] = getFeatures( input_img,img_border )
% Function: Get sift features and descriptors
global gauss_pyr; % 高斯金字塔
global dog_pyr; % 差分金字塔
global init_sigma;
global octvs; % 金字塔的高度
global intvls; % 金字塔中每一层的不同sigma进行高斯的层数
global ddata_array;
global features;
if(size(input_img,3)==3)
    input_img = rgb2gray(input_img);
end
input_img = im2double(input_img); % 讲输入图像转换为双精度
% %%%%%%%%%%%%%%%%%%%%%%
% %%  构建差分金字塔  %%
% %%%%%%%%%%%%%%%%%%%%%%
%% Build DoG Pyramid
% initial sigma  % sigma初始值
init_sigma = 1.6;
% number of intervals per octave % 每组的间隔
intvls = 3;
s = intvls;
k = 2^(1/s);
% 生成sigma数组，sigma，ksigma,k^2sigma,k^3sigma,k^4sigma,k^5sigma.
sigma = ones(1,s+3);
sigma(1) = init_sigma;
sigma(2) = init_sigma*sqrt(k*k-1);
for i = 3:s+3
    sigma(i) = sigma(i-1)*k;
end
% default cubic method
input_img = imresize(input_img,2); % 放大图像两倍
% assume the original image has a blur of sigma = 0.5 假设原图已有0.5的高斯平滑
input_img = gaussian(input_img,sqrt(init_sigma^2-0.5^2*4)); % 高斯平滑
% smallest dimension of top level is about 8 pixels 使顶层octave图像的长度和宽度最小值在8像素左右
octvs = floor(log( min(size(input_img)) )/log(2) - 2);

% gaussian pyramid 高斯金字塔
[img_height,img_width] =  size(input_img);
gauss_pyr = cell(octvs,1); % 高斯金字塔cell
% set image size % 设定金字塔每层图像大小
gimg_size = zeros(octvs,2); % 金字塔每层图像大小
gimg_size(1,:) = [img_height,img_width];
for i = 1:octvs
    if (i~=1)
        gimg_size(i,:) = [round(size(gauss_pyr{i-1},1)/2),round(size(gauss_pyr{i-1},2)/2)];
    end
    gauss_pyr{i} = zeros( gimg_size(i,1),gimg_size(i,2),s+3 ); % 初始化gauss_pyr cell
end
for i = 1:octvs
    for j = 1:s+3
        if (i==1 && j==1)
            gauss_pyr{i}(:,:,j) = input_img;
        % downsample for the first image in an octave, from the s+1 image
        % in previous octave.
        elseif (j==1)
            gauss_pyr{i}(:,:,j) = imresize(gauss_pyr{i-1}(:,:,s+1),0.5); % 上一个octave的s+1层，进行0.5下采样
        else
            gauss_pyr{i}(:,:,j) = gaussian(gauss_pyr{i}(:,:,j-1),sigma(j)); % 本octave的前一层，进行gaussian，参数从sigma数组中取
        end
    end
end
% dog pyramid 构建高斯差分金字塔cell(7,1)，每一个里面有gimg_size*gimg_size* s+2 的空间，s+2层，每个层放差分金字塔
dog_pyr = cell(octvs,1);
for i = 1:octvs
    dog_pyr{i} = zeros(gimg_size(i,1),gimg_size(i,2),s+2);
    for j = 1:s+2
    dog_pyr{i}(:,:,j) = gauss_pyr{i}(:,:,j+1) - gauss_pyr{i}(:,:,j);
    end
end
% for i = 1:size(dog_pyr,1)
%     for j = 1:size(dog_pyr{i},3)
%         imwrite(im2bw(im2uint8(dog_pyr{i}(:,:,j)),0),['dog_pyr\dog_pyr_',num2str(i),num2str(j),'.png']);
%     end
% end

% %%%%%%%%%%%%%%%%%%%%%%
% %%%%  关键点定位  %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Accurate Keypoint Localization
% width of border in which to ignore keypoints
% 忽略关键点的边框宽度 若关键点落在图像边缘区域（以img_border为宽度的矩形外框）也不认为此点为关键点
% img_border = 150; % 原图已经被扩大了两倍，所以边缘也要相应扩大
% maximum steps of keypoint interpolation
% 关键点插补的最大步长  若迭代5次位置仍不收敛，则不认为此点为关键点
max_interp_steps = 5;
% low threshold on feature contrast
% 特征对比低阈值 去除低反差
contr_thr = 0.12;
% high threshold on feature ratio of principal curvatures
% 主曲率特征比高阈值  消除边缘响应
curv_thr = 10;
prelim_contr_thr = 0.5*contr_thr/intvls;
ddata_array = struct('x',0,'y',0,'octv',0,'intvl',0,'x_hat',[0,0,0],'scl_octv',0);
ddata_index = 1;
for i = 1:octvs  % 取1-7 差分金字塔
    [height, width] = size(dog_pyr{i}(:,:,1));
    % find extrema in middle intvls 在中间层找极值
    for j = 2:s+1
        dog_imgs = dog_pyr{i}; % 取1-7 差分金字塔2-4层
        dog_img = dog_imgs(:,:,j); % 2-4层
        for x = img_border+1:height-img_border % 去边后一个像素一个像素过
            for y = img_border+1:width-img_border % 去边
            
                % preliminary check on contrast % 比较差异
                if(abs(dog_img(x,y)) > prelim_contr_thr) % 取绝对值，比较和预设的阈值差异
                    % check 26 neighboring pixels 检查26个相邻像素
                    if(isExtremum(j,x,y)) % 是否极值点，是的话，进入interpLocation进行计算看是否加入ddata
                        ddata = interpLocation(dog_imgs,height,width,i,j,x,y,img_border,contr_thr,max_interp_steps);
                        if(~isempty(ddata)) % 如果ddata不为空
                            if(~isEdgeLike(dog_img,ddata.x,ddata.y,curv_thr)) % 判断不是边缘点
                                 ddata_array(ddata_index) = ddata; % 加入点array
                                 ddata_index = ddata_index + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end

function [ flag ] = isExtremum( intvl, x, y)
% Function: Find Extrema in 26 neighboring pixels 看其是不是26个相邻像素中的极值点
    value = dog_imgs(x,y,intvl);
    block = dog_imgs(x-1:x+1,y-1:y+1,intvl-1:intvl+1);
    if ( value > 0 && value == max(block(:)) )
        flag = 1;
    elseif ( value == min(block(:)) )
        flag = 1;
    else
        flag = 0;
    end
end

% %%%%%%%%%%%%%%%%%%%%%%
% %%%%   方向指定   %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Orientation Assignment
% number of detected points 探测点数目
n = size(ddata_array,2); % ddata_array (1,n),现在只取第二个size，看有多少ddata
% determines gaussian sigma for orientation assignment 确定定位分配的高斯sigma
ori_sig_factr = 1.5;
% number of bins in histogram 直方图中的箱子数
ori_hist_bins = 36; % 将360度的方向划分为36个区域(
% orientation magnitude relative to max that results in new feature 相对于最大值的方向大小，从而产生新的特征
% 如果除了主方向，还有一个方向大小大于主方向大小的80%，则将其也加入特征
ori_peak_ratio = 0.8;
% array of feature 特征数组
features = struct('ddata_index',0,'x',0,'y',0,'scl',0,'ori',0,'descr',[]);
% ori ---- 主方向角度，范围(-pi,pi]
% scl --- 特征权重？
feat_index = 1;
for i = 1:n % 遍历所有ddata_array
    ddata = ddata_array(i);
    ori_sigma = ori_sig_factr * ddata.scl_octv; % 1.5* scl_octv 1.5sigma
    % generate a histogram for the gradient distribution around a keypoint 生成一个围绕一个关键点的梯度分布的直方图
    % 得到36个方向的直方图，hist(36,1) 36个方向的bin
    hist = oriHist(gauss_pyr{ddata.octv}(:,:,ddata.intvl),ddata.x,ddata.y,ori_hist_bins,round(3*ori_sigma),ori_sigma);
    for j = 1:2
        smoothOriHist(hist,ori_hist_bins); % 然后对直方图进行两次平滑处理，即按0.25,0.5,0.25的大小对每3个连续的bin加权两次。
    end
    % generate feature from ddata and orientation hist peak 从ddata和方向hist峰值生成特征
    % add orientations greater than or equal to 80% of the largest orientation magnitude 
    % 添加大于或等于最大方向幅度80%的方向作为辅助方向
    feat_index = addOriFeatures(i,feat_index,ddata,hist,ori_hist_bins,ori_peak_ratio);
end


% %%%%%%%%%%%%%%%%%%%%%%
% %%%%  描述符生成  %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Descriptor Generation
% number of features feature的数量
n = size(features,2);
% width of 2d array of orientation histograms 二维方向直方图阵列的宽度
descr_hist_d = 4;
% bins per orientation histogram 每个方向直方图
descr_hist_obins = 8;
% threshold on magnitude of elements of descriptor vector 描述向量的元素大小的阈值
descr_mag_thr = 0.2;
descr_length = descr_hist_d*descr_hist_d*descr_hist_obins;
local_features = features;
local_ddata_array = ddata_array;
local_gauss_pyr = gauss_pyr;
clear features;
clear ddata_array;
clear gauss_pyr;
clear dog_pyr;
parfor feat_index = 1:n
    feat = local_features(feat_index);
    ddata = local_ddata_array(feat.ddata_index);
    gauss_img = local_gauss_pyr{ddata.octv}(:,:,ddata.intvl);
% computes the 2D array of orientation histograms that form the feature descriptor
% 计算形成特征描述符的方向直方图的2D数组
    hist_width = 3*ddata.scl_octv; % 3 simga
    radius = round( hist_width * (descr_hist_d + 1) * sqrt(2) / 2 );
    feat_ori = feat.ori; % 主方向角度
    ddata_x = ddata.x;
    ddata_y = ddata.y;
    hist = zeros(1,descr_length);  % 4*4*8=128
    for i = -radius:radius
        for j = -radius:radius
            j_rot = j*cos(feat_ori) - i*sin(feat_ori);
            i_rot = j*sin(feat_ori) + i*cos(feat_ori);
            r_bin = i_rot/hist_width + descr_hist_d/2 - 0.5;
            c_bin = j_rot/hist_width + descr_hist_d/2 - 0.5;
            if (r_bin > -1 && r_bin < descr_hist_d && c_bin > -1 && c_bin < descr_hist_d)
                mag_ori = calcGrad(gauss_img,ddata_x+i,ddata_y+j);
                if (mag_ori(1) ~= -1)
                    ori = mag_ori(2);
                    ori = ori - feat_ori;
                    while (ori < 0)
                        ori = ori + 2*pi;
                    end
                    % i think it's theoretically impossible
                    while (ori >= 2*pi)
                        ori = ori - 2*pi;
                        disp('###################what the fuck?###################');
                    end
                    o_bin = ori * descr_hist_obins / (2*pi);% 判断在8个方向中的哪一个
                    w = exp( -(j_rot*j_rot+i_rot*i_rot) / (2*(0.5*descr_hist_d*hist_width)^2) );
                    hist = interpHistEntry(hist,r_bin,c_bin,o_bin,mag_ori(1)*w,descr_hist_d,descr_hist_obins);
                    % hist (1*128 )
                end
            end
        end
    end
    % 添加descr，从hist转为feature的descr
    local_features(feat_index) = hist2Descr(feat,hist,descr_mag_thr); % descr_mag_thr 描述向量的元素大小的阈值
end
% sort the descriptors by descending scale order
% 按降序排列描述符 scl，特征权重
features_scl = [local_features.scl];
[~,features_order] = sort(features_scl,'descend');
% return descriptors and locations
% 返回描述符和位置
descrs = zeros(n,descr_length); % n*128  n为feature的数量
locs = zeros(n,2);
for i = 1:n
    descrs(i,:) = local_features(features_order(i)).descr;
    locs(i,1) = local_features(features_order(i)).x;
    locs(i,2) = local_features(features_order(i)).y;
end

end