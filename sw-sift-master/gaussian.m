% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ out_img ] = gaussian( input_img, sigma )
% Function: Gaussian smooth for an image
k = 3;
hsize = round(2*k*sigma+1); % 四舍五入 6sigma+1  3σ准则，高斯核矩阵的大小
% 保证行列为奇数
if mod(hsize,2) == 0
    hsize = hsize+1;
end
% fspecial用于创建预定义的滤波算子
g = fspecial('gaussian',hsize,sigma); % 滤波，高斯，hsize大小，sigma标准差
% cov2计算二维卷积  same 返回二维卷积结果中与input_img大小相同的中间部分
out_img = conv2(input_img,g,'same');
end
