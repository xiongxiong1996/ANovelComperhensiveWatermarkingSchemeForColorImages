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
% -----�˹���Ӧ��ˮӡǶ��ʱ���У���des1��loc1���б��浱����Կ
img1 = imread('lena.png'); % ԭͼ
[des1,loc1] = getFeatures(img1,5);
% ----------------------------------------------------------------
% -----�˹���Ӧ������ȡ�����н���
% img2Ϊ��ˮӡͼ�񣬶�ȡdes1��loc1
% img2 = imread('lena_r.png'); % ������ת������ͼ��

img5 = imrotate(img1,-5,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
img10 = imrotate(img1,-10,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
img30 = imrotate(img1,-30,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
img45 = imrotate(img1,-45,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
img60 = imrotate(img1,-60,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
img90 = imrotate(img1,-90,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
[recover_img,angle,avgAngle5] = d_reoverRotation(des1,loc1,img5); % ������ת�ָ��������лָ�,���ص�angle����ϴ�������
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