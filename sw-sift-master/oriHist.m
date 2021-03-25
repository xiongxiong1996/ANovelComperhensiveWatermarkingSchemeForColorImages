% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ hist ] = oriHist( img, x, y, n, rad, sigma )
% Function: Calculate orientation histogram 计算方向直方图
% rad = 3*sigma 尺度采样3sigma
% n = 36，36个bin
% img 为高斯金字塔中，一个octv中的intvl
hist = zeros(n,1);
exp_factor = 2*sigma*sigma;
for i = -rad:rad 
    for j = -rad:rad
        [mag_ori] = calcGrad(img,x+i,y+j); % 计算每个像素的梯度和反正切 mag_ori[距离梯度幅值，反正切梯度方向角度]
        if(mag_ori(1) ~= -1)
            w = exp( -(i*i+j*j)/exp_factor ); % exp,e的幂，权重值
            bin = 1 + round( n*(mag_ori(2) + pi)/(2*pi) );% 计算归入哪个bin
            if(bin == n +1)
                bin = 1;
            end
            hist(bin) = hist(bin) + w*mag_ori(1);
        end
    end
end
end