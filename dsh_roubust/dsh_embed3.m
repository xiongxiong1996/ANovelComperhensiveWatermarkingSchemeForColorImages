function [watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname,n,a,b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% f1.grey scaleͼ�� shearlet�任��ȡ��Ƶ����1level-DWT��ȡLL����
% f2.LL�������4*4�ֿ��ÿһ��SVD ȡ��S�����ֵ��Ƕ��ˮӡ����
% f3.LL'���������任�õ�watermaked Img

% ���룺hotst_image---����ͼ��
% ���룺wImg---ˮӡͼ��
% ���룺s1---shearlet�任����
% ���룺block_size---�ֿ��С
% ���룺dt---ˮӡǶ�벽��
% ���룺wname---С���任С����
% ���룺n,a,b---Arnold���Ҳ���

% �����watermarked_Img---Ƕ��ˮӡ���ͼ��
% �����psnr_32---Ƕ��ˮӡ���PSNR

% ---------------------------------------------------------
if nargin < 7
	n = 10;
	a=3;
	b=5;
end

thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wbImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
w_Img = dsh_arnold(wbImg,n,a,b); % ˮӡ���Ҵ��� n=10 a=3 b=5
% w_Img =logistic_permutation_swap(wbImg,0.5,3.9); % ˮӡ����


[n n] =size(w_Img); % ˮӡ�Ĵ�С 32*32


% �Ƚ���ͼ���м䲿�ֵ���ȡ������ȡͼ���м��256*256�Ĳ��֡����ⲿ�ֽ��д���

x1 = 129;
y1 = 129;
x2 = 384;
y2 = 384;
centerImg = imcrop(host_image,[129,129,255,255]); % ��ȡ�̶�����

% centerͼ�� shearlet�任��ȡ��Ƶ����

[ll,dst,shear_f,lpfilt,ch,cv,cd]=d_get_ll(centerImg,s1,wname); 


ll_prim=d_embed_watermark3(ll,w_Img,block_size,dt); 

watermarked_centerImg=d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd);  % ȡ��Ƕ��ˮӡ���ll_prim��任����ˮӡͼ��


watermarked_Img = host_image;

% ������ͼ�����ˮӡͼ��
for i=x1:x2
	for j=y1:y2
		watermarked_Img(i,j)=watermarked_centerImg(i-128,j-128);
	end
end
% imwrite(watermarked_Img,'watermarkedImg.tiff'); % ��ˮӡͼ�񱣴�
psnr_32 = psnr(host_image,watermarked_Img); % ����PSNR
end

