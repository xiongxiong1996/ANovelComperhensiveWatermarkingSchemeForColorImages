function [watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname,n,a,b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% f1.grey scale图像 shearlet变换，取低频区域，1level-DWT，取LL区域
% f2.LL区域进行4*4分块对每一块SVD 取出S的最大值，嵌入水印序列
% f3.LL'区域进行逆变换得到watermaked Img

% 输入：hotst_image---宿主图像
% 输入：wImg---水印图像
% 输入：s1---shearlet变换级数
% 输入：block_size---分块大小
% 输入：dt---水印嵌入步长
% 输入：wname---小波变换小波名
% 输入：n,a,b---Arnold置乱参数

% 输出：watermarked_Img---嵌入水印后的图像
% 输出：psnr_32---嵌入水印后的PSNR

% ---------------------------------------------------------
if nargin < 7
	n = 10;
	a=3;
	b=5;
end

thresh =graythresh(wImg);     % 自动确定二值化阈值
wbImg = im2bw(wImg,thresh);   % 对图像二值化
w_Img = dsh_arnold(wbImg,n,a,b); % 水印置乱处理 n=10 a=3 b=5
% w_Img =logistic_permutation_swap(wbImg,0.5,3.9); % 水印置乱


[n n] =size(w_Img); % 水印的大小 32*32


% 先进行图像中间部分的提取，我们取图像中间的256*256的部分。对这部分进行处理

x1 = 129;
y1 = 129;
x2 = 384;
y2 = 384;
centerImg = imcrop(host_image,[129,129,255,255]); % 截取固定区域

% center图像 shearlet变换，取低频区域

[ll,dst,shear_f,lpfilt,ch,cv,cd]=d_get_ll(centerImg,s1,wname); 


ll_prim=d_embed_watermark3(ll,w_Img,block_size,dt); 

watermarked_centerImg=d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd);  % 取出嵌入水印后的ll_prim逆变换生成水印图像


watermarked_Img = host_image;

% 将中心图像填回水印图像
for i=x1:x2
	for j=y1:y2
		watermarked_Img(i,j)=watermarked_centerImg(i-128,j-128);
	end
end
% imwrite(watermarked_Img,'watermarkedImg.tiff'); % 将水印图像保存
psnr_32 = psnr(host_image,watermarked_Img); % 计算PSNR
end

