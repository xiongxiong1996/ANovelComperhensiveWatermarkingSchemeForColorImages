% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% 本函数用于找到最佳的lambda值，水印鲁棒性和PSNR

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%      水印宿主图像处理    %%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
host_image= imread('lena512.pgm'); % 读入宿主图像
wImg=imread('wImg32.png'); % 读入水印图像

thresh =graythresh(wImg);     % 自动确定二值化阈值
wbImg = im2bw(wImg,thresh);   % 对图像二值化
ow_Img=wbImg;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      参数定义    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet变换级数
block_size=8; % 块大小
wname='db2'; % DWT变换小波名

a_list=zeros(30,3);
for lambda=1:30
	[watermarked_Img,psnr_32] = dsh_embed2(host_image,wImg,s1,block_size,lambda,wname);
	[avg_nc] = dsh_get_avgnc2(watermarked_Img,ow_Img,s1,block_size,wname);
	a_list(lambda,1)=lambda;
	a_list(lambda,2)=psnr_32;
	a_list(lambda,3)=avg_nc;
end
