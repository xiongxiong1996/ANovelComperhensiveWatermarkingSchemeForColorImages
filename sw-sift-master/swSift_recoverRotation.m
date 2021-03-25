% 
%   Copyright (C) 2020  Shaohua Duan <shaohua1996wy@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

clear
tic
% img1 = imread('scene.pgm');
% img2 = imread('book.pgm');
% -----此过程应在水印嵌入时进行，对des1，loc1进行保存当作密钥
img1 = imread('lena.png'); % 原图
[des1,loc1] = getFeatures(img1,5);
% ----------------------------------------------------------------
% -----此过程应该在提取过程中进行
% img2为含水印图像，读取des1，loc1
% img2 = imread('lena_r.png'); % 遭受旋转攻击的图像

img5 = imrotate(img1,-5,'crop'); % 得到的旋转后图像和原图大小相同
img10 = imrotate(img1,-10,'crop'); % 得到的旋转后图像和原图大小相同
img30 = imrotate(img1,-30,'crop'); % 得到的旋转后图像和原图大小相同
img45 = imrotate(img1,-45,'crop'); % 得到的旋转后图像和原图大小相同
img60 = imrotate(img1,-60,'crop'); % 得到的旋转后图像和原图大小相同
img90 = imrotate(img1,-90,'crop'); % 得到的旋转后图像和原图大小相同
[recover_img,angle,avgAngle5] = d_reoverRotation(des1,loc1,img5); % 调用旋转恢复函数进行恢复,返回的angle是清洗后的数据
[recover_img,angle,avgAngle10] = d_reoverRotation(des1,loc1,img10);
[recover_img,angle,avgAngle30] = d_reoverRotation(des1,loc1,img30);
[recover_img,angle,avgAngle45] = d_reoverRotation(des1,loc1,img45);
[recover_img,angle,avgAngle60] = d_reoverRotation(des1,loc1,img60);
[recover_img,angle,avgAngle90] = d_reoverRotation(des1,loc1,img90);
% figure(1);
% imshow(img1);
% figure(2);
% imshow(img2);
% figure(3);
% imshow(recover_img);
toc