% 尝试实现SVD的盲水印方案3。步骤如下
% f1.grey scale图像 shearlet变换，取低频区域，1level-DWT，取LL区域
% f2.LL区域进行4*4分块 取出S的最大值，嵌入水印序列
% f3.LL'区域进行逆变换得到watermaked Img
% % shearlet DWT  SVD 嵌入

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%      水印宿主图像处理    %%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
host_image= imread('lena512.pgm'); % 读入宿主图像
% host_image= imread('man.tiff'); % 读入宿主图像
% host_image= imread('peppers.tiff'); % 读入宿主图像
wImg=imread('wImg32.png'); % 读入水印图像


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      参数定义    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet变换级数
block_size=4; % 块大小
dt=85; % 嵌入强度的确定
wname='db2'; % DWT变换小波名

[watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname)

imwrite(watermarked_Img,'watermarkedImg.tiff'); % 将水印图像保存

psnr_32 = psnr(host_image,watermarked_Img); % 计算PSNR

[extract_w] = dsh_extract3(watermarked_Img,s1,block_size,wname,dt,32) % 从水印图像中提取水印

[att] = dsh_attact_test3(wImg,watermarked_Img,s1,block_size,wname,dt,32);
% [att] = dsh_attact_test(wImg,watermarked_Img,s1,block_size,wname,32);