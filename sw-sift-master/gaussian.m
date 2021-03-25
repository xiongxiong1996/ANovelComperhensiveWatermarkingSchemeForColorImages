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
hsize = round(2*k*sigma+1); % �������� 6sigma+1  3��׼�򣬸�˹�˾���Ĵ�С
% ��֤����Ϊ����
if mod(hsize,2) == 0
    hsize = hsize+1;
end
% fspecial���ڴ���Ԥ������˲�����
g = fspecial('gaussian',hsize,sigma); % �˲�����˹��hsize��С��sigma��׼��
% cov2�����ά���  same ���ض�ά����������input_img��С��ͬ���м䲿��
out_img = conv2(input_img,g,'same');
end
