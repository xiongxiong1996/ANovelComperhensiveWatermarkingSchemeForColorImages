% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ descrs, locs ] = getFeatures( input_img,img_border )
% Function: Get sift features and descriptors
global gauss_pyr; % ��˹������
global dog_pyr; % ��ֽ�����
global init_sigma;
global octvs; % �������ĸ߶�
global intvls; % ��������ÿһ��Ĳ�ͬsigma���и�˹�Ĳ���
global ddata_array;
global features;
if(size(input_img,3)==3)
    input_img = rgb2gray(input_img);
end
input_img = im2double(input_img); % ������ͼ��ת��Ϊ˫����
% %%%%%%%%%%%%%%%%%%%%%%
% %%  ������ֽ�����  %%
% %%%%%%%%%%%%%%%%%%%%%%
%% Build DoG Pyramid
% initial sigma  % sigma��ʼֵ
init_sigma = 1.6;
% number of intervals per octave % ÿ��ļ��
intvls = 3;
s = intvls;
k = 2^(1/s);
% ����sigma���飬sigma��ksigma,k^2sigma,k^3sigma,k^4sigma,k^5sigma.
sigma = ones(1,s+3);
sigma(1) = init_sigma;
sigma(2) = init_sigma*sqrt(k*k-1);
for i = 3:s+3
    sigma(i) = sigma(i-1)*k;
end
% default cubic method
input_img = imresize(input_img,2); % �Ŵ�ͼ������
% assume the original image has a blur of sigma = 0.5 ����ԭͼ����0.5�ĸ�˹ƽ��
input_img = gaussian(input_img,sqrt(init_sigma^2-0.5^2*4)); % ��˹ƽ��
% smallest dimension of top level is about 8 pixels ʹ����octaveͼ��ĳ��ȺͿ����Сֵ��8��������
octvs = floor(log( min(size(input_img)) )/log(2) - 2);

% gaussian pyramid ��˹������
[img_height,img_width] =  size(input_img);
gauss_pyr = cell(octvs,1); % ��˹������cell
% set image size % �趨������ÿ��ͼ���С
gimg_size = zeros(octvs,2); % ������ÿ��ͼ���С
gimg_size(1,:) = [img_height,img_width];
for i = 1:octvs
    if (i~=1)
        gimg_size(i,:) = [round(size(gauss_pyr{i-1},1)/2),round(size(gauss_pyr{i-1},2)/2)];
    end
    gauss_pyr{i} = zeros( gimg_size(i,1),gimg_size(i,2),s+3 ); % ��ʼ��gauss_pyr cell
end
for i = 1:octvs
    for j = 1:s+3
        if (i==1 && j==1)
            gauss_pyr{i}(:,:,j) = input_img;
        % downsample for the first image in an octave, from the s+1 image
        % in previous octave.
        elseif (j==1)
            gauss_pyr{i}(:,:,j) = imresize(gauss_pyr{i-1}(:,:,s+1),0.5); % ��һ��octave��s+1�㣬����0.5�²���
        else
            gauss_pyr{i}(:,:,j) = gaussian(gauss_pyr{i}(:,:,j-1),sigma(j)); % ��octave��ǰһ�㣬����gaussian��������sigma������ȡ
        end
    end
end
% dog pyramid ������˹��ֽ�����cell(7,1)��ÿһ��������gimg_size*gimg_size* s+2 �Ŀռ䣬s+2�㣬ÿ����Ų�ֽ�����
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
% %%%%  �ؼ��㶨λ  %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Accurate Keypoint Localization
% width of border in which to ignore keypoints
% ���Թؼ���ı߿��� ���ؼ�������ͼ���Ե������img_borderΪ��ȵľ������Ҳ����Ϊ�˵�Ϊ�ؼ���
% img_border = 150; % ԭͼ�Ѿ������������������Ա�ԵҲҪ��Ӧ����
% maximum steps of keypoint interpolation
% �ؼ���岹����󲽳�  ������5��λ���Բ�����������Ϊ�˵�Ϊ�ؼ���
max_interp_steps = 5;
% low threshold on feature contrast
% �����Աȵ���ֵ ȥ���ͷ���
contr_thr = 0.12;
% high threshold on feature ratio of principal curvatures
% �����������ȸ���ֵ  ������Ե��Ӧ
curv_thr = 10;
prelim_contr_thr = 0.5*contr_thr/intvls;
ddata_array = struct('x',0,'y',0,'octv',0,'intvl',0,'x_hat',[0,0,0],'scl_octv',0);
ddata_index = 1;
for i = 1:octvs  % ȡ1-7 ��ֽ�����
    [height, width] = size(dog_pyr{i}(:,:,1));
    % find extrema in middle intvls ���м���Ҽ�ֵ
    for j = 2:s+1
        dog_imgs = dog_pyr{i}; % ȡ1-7 ��ֽ�����2-4��
        dog_img = dog_imgs(:,:,j); % 2-4��
        for x = img_border+1:height-img_border % ȥ�ߺ�һ������һ�����ع�
            for y = img_border+1:width-img_border % ȥ��
            
                % preliminary check on contrast % �Ƚϲ���
                if(abs(dog_img(x,y)) > prelim_contr_thr) % ȡ����ֵ���ȽϺ�Ԥ�����ֵ����
                    % check 26 neighboring pixels ���26����������
                    if(isExtremum(j,x,y)) % �Ƿ�ֵ�㣬�ǵĻ�������interpLocation���м��㿴�Ƿ����ddata
                        ddata = interpLocation(dog_imgs,height,width,i,j,x,y,img_border,contr_thr,max_interp_steps);
                        if(~isempty(ddata)) % ���ddata��Ϊ��
                            if(~isEdgeLike(dog_img,ddata.x,ddata.y,curv_thr)) % �жϲ��Ǳ�Ե��
                                 ddata_array(ddata_index) = ddata; % �����array
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
% Function: Find Extrema in 26 neighboring pixels �����ǲ���26�����������еļ�ֵ��
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
% %%%%   ����ָ��   %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Orientation Assignment
% number of detected points ̽�����Ŀ
n = size(ddata_array,2); % ddata_array (1,n),����ֻȡ�ڶ���size�����ж���ddata
% determines gaussian sigma for orientation assignment ȷ����λ����ĸ�˹sigma
ori_sig_factr = 1.5;
% number of bins in histogram ֱ��ͼ�е�������
ori_hist_bins = 36; % ��360�ȵķ��򻮷�Ϊ36������(
% orientation magnitude relative to max that results in new feature ��������ֵ�ķ����С���Ӷ������µ�����
% ������������򣬻���һ�������С�����������С��80%������Ҳ��������
ori_peak_ratio = 0.8;
% array of feature ��������
features = struct('ddata_index',0,'x',0,'y',0,'scl',0,'ori',0,'descr',[]);
% ori ---- ������Ƕȣ���Χ(-pi,pi]
% scl --- ����Ȩ�أ�
feat_index = 1;
for i = 1:n % ��������ddata_array
    ddata = ddata_array(i);
    ori_sigma = ori_sig_factr * ddata.scl_octv; % 1.5* scl_octv 1.5sigma
    % generate a histogram for the gradient distribution around a keypoint ����һ��Χ��һ���ؼ�����ݶȷֲ���ֱ��ͼ
    % �õ�36�������ֱ��ͼ��hist(36,1) 36�������bin
    hist = oriHist(gauss_pyr{ddata.octv}(:,:,ddata.intvl),ddata.x,ddata.y,ori_hist_bins,round(3*ori_sigma),ori_sigma);
    for j = 1:2
        smoothOriHist(hist,ori_hist_bins); % Ȼ���ֱ��ͼ��������ƽ����������0.25,0.5,0.25�Ĵ�С��ÿ3��������bin��Ȩ���Ρ�
    end
    % generate feature from ddata and orientation hist peak ��ddata�ͷ���hist��ֵ��������
    % add orientations greater than or equal to 80% of the largest orientation magnitude 
    % ��Ӵ��ڻ������������80%�ķ�����Ϊ��������
    feat_index = addOriFeatures(i,feat_index,ddata,hist,ori_hist_bins,ori_peak_ratio);
end


% %%%%%%%%%%%%%%%%%%%%%%
% %%%%  ����������  %%%%
% %%%%%%%%%%%%%%%%%%%%%%
%% Descriptor Generation
% number of features feature������
n = size(features,2);
% width of 2d array of orientation histograms ��ά����ֱ��ͼ���еĿ��
descr_hist_d = 4;
% bins per orientation histogram ÿ������ֱ��ͼ
descr_hist_obins = 8;
% threshold on magnitude of elements of descriptor vector ����������Ԫ�ش�С����ֵ
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
% �����γ������������ķ���ֱ��ͼ��2D����
    hist_width = 3*ddata.scl_octv; % 3 simga
    radius = round( hist_width * (descr_hist_d + 1) * sqrt(2) / 2 );
    feat_ori = feat.ori; % ������Ƕ�
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
                    o_bin = ori * descr_hist_obins / (2*pi);% �ж���8�������е���һ��
                    w = exp( -(j_rot*j_rot+i_rot*i_rot) / (2*(0.5*descr_hist_d*hist_width)^2) );
                    hist = interpHistEntry(hist,r_bin,c_bin,o_bin,mag_ori(1)*w,descr_hist_d,descr_hist_obins);
                    % hist (1*128 )
                end
            end
        end
    end
    % ���descr����histתΪfeature��descr
    local_features(feat_index) = hist2Descr(feat,hist,descr_mag_thr); % descr_mag_thr ����������Ԫ�ش�С����ֵ
end
% sort the descriptors by descending scale order
% ���������������� scl������Ȩ��
features_scl = [local_features.scl];
[~,features_order] = sort(features_scl,'descend');
% return descriptors and locations
% ������������λ��
descrs = zeros(n,descr_length); % n*128  nΪfeature������
locs = zeros(n,2);
for i = 1:n
    descrs(i,:) = local_features(features_order(i)).descr;
    locs(i,1) = local_features(features_order(i)).x;
    locs(i,2) = local_features(features_order(i)).y;
end

end