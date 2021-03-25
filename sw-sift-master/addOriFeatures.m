% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [feat_index] = addOriFeatures(ddata_index,feat_index,ddata,hist,n,ori_peak_ratio)
% Function: Add good orientation for keypoints
% 添加特征
% ddata_index(i),确定ddata位置，定位到哪层哪个点
% feat_index，特征索引，确定当前特征位置
% ddata，用于根据index找到信息
% hist 含有36个bin的直方图
% n ori_hist_bins =36
% ori_peak_ratio 峰值比率，用于确定辅助方向
global features;
global init_sigma;
global intvls;
omax = dominantOri(hist,n); % 取出峰值最大的方向
for i = 1:n
    if (i==1)
            l = n;
            r = 2;
    elseif (i==n)
        l = n-1;
        r = 1;
    else
        l = i-1;
        r = i+1;
    end
    if ( hist(i) > hist(l) && hist(i) > hist(r) && hist(i) >= ori_peak_ratio*omax )% 比两边都高，且比率为最大的80%作为辅助方向
        bin = i + interp_hist_peak(hist(l),hist(i),hist(r));% 更加精确的bin，带小数，对于一个方向，根据其两边进行调整。使用了插值
        if ( bin -1 <= 0 )		
            bin = bin + n;
        % i think it's theoretically impossible
        elseif ( bin -1 > n )
            bin = bin - n;
            disp('###################what the fuck?###################');
        end
        accu_intvl = ddata.intvl + ddata.x_hat(3); % 当前层加了一个层偏移
        features(feat_index).ddata_index = ddata_index; % ddata数组的索引
        % first octave is double size 第一个层是双倍大小（图像做了一次放大）
        features(feat_index).x = (ddata.x + ddata.x_hat(1))*2^(ddata.octv-2); % 加了偏移，乘以2的金字塔层数减2次幂
        features(feat_index).y = (ddata.y + ddata.x_hat(2))*2^(ddata.octv-2);
        features(feat_index).scl = init_sigma * power(2,ddata.octv-2 + (accu_intvl-1)/intvls);  % power(2,....)，返回2的次方
        features(feat_index).ori = (bin-1)/n*2*pi - pi; % 主方向角度，范围(-pi,pi]
        feat_index = feat_index + 1; % 特征的索引
    end
end
end

function [omax] = dominantOri(hist,n)
% 取出峰值最大的方向
    omax = hist(1);
    for i = 2:n
        if(hist(i) > omax)
            omax = hist(i);
        end
    end
end

function [position] = interp_hist_peak(l,c,r)
    position = 0.5*(l-r)/(l-2*c+r);
end