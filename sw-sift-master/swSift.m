% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

clear
tic
% img1 = imread('scene.pgm');
% img2 = imread('book.pgm');
img1 = imread('lena.png');
img2 = imread('lena_r.png');

[des1,loc1] = getFeatures(img1,50);
[des2,loc2] = getFeatures(img2,5);
matched = match(des1,des2,0.6);
drawFeatures(img1,loc1);
drawFeatures(img2,loc2);
drawMatched(matched,img1,img2,loc1,loc2);
toc