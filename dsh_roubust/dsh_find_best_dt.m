% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% 本函数用于找到dt的最佳值，再保证水印质量的同时，兼顾PSNR

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
block_size=4; % 块大小
wname='db2'; % DWT变换小波名

dt=85; % 嵌入强度的确定
a_list=zeros(50,3);
for dt=1:4:117
	[watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname);
	[avg_nc] = dsh_get_avgnc3(watermarked_Img,ow_Img,s1,block_size,wname,dt);
	a_list(floor(dt/4)+1,1)=dt;
	a_list(floor(dt/4)+1,2)=psnr_32;
	a_list(floor(dt/4)+1,3)=avg_nc;
end
