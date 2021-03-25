function [watermarked_Img,psnr_32] = dsh_embed2(host_image,wImg,s1,block_size,lambda,wname,n,a,b)

% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% f1.grey scale图像 shearlet变换，取低频区域，1level-DWT，取LL区域
% f2.LL区域进行8*8分块对每一块进行DCT，选取两个matrixs 取出S的最大值，嵌入水印序列
% f3.LL'区域进行逆变换得到watermaked Img

% 输入：hotst_image---宿主图像
% 输入：wImg---水印图像
% 输入：s1---shearlet变换级数
% 输入：block_size---分块大小
% 输入：lambda---水印嵌入强度
% 输入：wname---小波变换小波名
% 输入：n,a,b---Arnold置乱参数

% 输出：watermarked_Img---嵌入水印后的图像
% 输出：psnr_32---嵌入水印后的PSNR

% ---------------------------------------------------------
% s1=1  % shearlet变换级数 block_size=8; % 块大小 lambda=25; % 嵌入强度的确定 wname='db2'; % DWT变换小波名
if nargin < 7
	n = 10;
	a=3;
	b=5; 
end
% 如果输入参数小于7则给n,a,b默认值。
thresh =graythresh(wImg);     % 自动确定二值化阈值
wbImg = im2bw(wImg,thresh);   % 对图像二值化
w_Img = dsh_arnold(wbImg,n,a,b); % 水印置乱处理 n=10 a=3 b=5
% w_Img =logistic_permutation_swap(wbImg,0.5,3.9); % 水印置乱

[n n] =size(w_Img); % 水印的大小 32*32

[ll,dst,shear_f,lpfilt,ch,cv,cd]=d_get_ll(host_image,s1,wname);  % grey scale图像 shearlet变换，取低频区域，1level-DWT，取LL区域


ll_prim=d_embed_watermark2(ll,w_Img,block_size,lambda); % LL区域进行8*8分块对每一块取出m1 m2 SVD取出S的最大值，嵌入水印序列


watermarked_Img=d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd);  % 取出嵌入水印后的ll_prim逆变换生成水印图像


% imwrite(watermarked_Img,'watermarkedImg.tiff'); % 将水印图像保存


psnr_32 = psnr(host_image,watermarked_Img); % 计算PSNR
end