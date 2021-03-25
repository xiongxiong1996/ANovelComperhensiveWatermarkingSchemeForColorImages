% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% 本实验用于找到最适合的lambda和dt用于嵌入。
% 生成的数据会存到excel中，后期绘制PSNR图用到数据及从此处所来
clear
tic
% 宿主图像读取
hostImage = imread('lena512color.tiff'); 
% 读入水印图像 
wImg=imread('wImg32.png'); % 读入水印图像

thresh =graythresh(wImg);     % 自动确定二值化阈值
wbImg = im2bw(wImg,thresh);   % 对图像二值化
ow_Img=wbImg;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      参数定义    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet变换级数
block_size1=8; % 鲁棒水印1 分块大小
block_size2=4; % 鲁棒水印2 分块大小
block_size3=16; % 脆弱水印 分块大小
wname='db2'; % 鲁棒水印1 2 DWT变换小波名
img_border=5; % 旋转矫正边缘空出宽度





% 对宿主图像进行分层
ht1=hostImage(:,:,1); % R
ht2=hostImage(:,:,2); % G
ht3=hostImage(:,:,3); % B

psnr_list=zeros(30,30);
robust1_list=zeros(30,30);
robust2_list=zeros(30,30);
for lambda=1:30  %  1:5:16
	for dt=1:4:117  %  1:19:77
		watermarkedImg = hostImage;
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%    水印1嵌入   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		w1 = dsh_embed2(ht1,wImg,s1,block_size1,lambda,wname); % 调用水印嵌入方法，嵌入鲁棒水印1
		watermarkedImg(:,:,1) = w1; % 使用嵌入水印后的R层替换水印图像中的R层
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%    水印2嵌入   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		w2 = dsh_embed3(ht2,wImg,s1,block_size2,dt,wname); % 调用水印嵌入方法，嵌入鲁棒水印2
		watermarkedImg(:,:,2) = w2; % 使用嵌入水印后的R层替换水印图像中的G层
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%    水印3嵌入   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		watermarkedImg = dsh_embedFragileW(watermarkedImg,block_size3); % 调用水印嵌入方法，嵌入脆弱水印。输入参数：嵌入鲁棒水印后的图像，分块大小
		% 计算参数保存
		psnr_32 = psnr(hostImage,watermarkedImg); % 计算PSNR
		avg_nc1 = dsh_get_avgnc2(w1,ow_Img,s1,block_size1,wname);
		avg_nc2 = dsh_get_avgnc3(w2,ow_Img,s1,block_size2,wname,dt);
% 		psnr_list(floor(lambda/5)+1,floor(dt/19)+1)=psnr_32;
% 		robust1_list(floor(lambda/5)+1,floor(dt/19)+1)= avg_nc1;
% 		robust2_list(floor(lambda/5)+1,floor(dt/19)+1) = avg_nc2;
		psnr_list(lambda,floor(dt/4)+1)=psnr_32;
		robust1_list(lambda,floor(dt/4)+1)= avg_nc1;
		robust2_list(lambda,floor(dt/4)+1) = avg_nc2;
	end
end

xlswrite('psnr_list.xls',psnr_list);
xlswrite('robust1_list.xls',robust1_list);
xlswrite('robust2_list.xls',robust2_list);
toc