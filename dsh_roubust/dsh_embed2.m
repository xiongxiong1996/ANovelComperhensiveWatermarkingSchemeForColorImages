function [watermarked_Img,psnr_32] = dsh_embed2(host_image,wImg,s1,block_size,lambda,wname,n,a,b)

% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% f1.grey scaleͼ�� shearlet�任��ȡ��Ƶ����1level-DWT��ȡLL����
% f2.LL�������8*8�ֿ��ÿһ�����DCT��ѡȡ����matrixs ȡ��S�����ֵ��Ƕ��ˮӡ����
% f3.LL'���������任�õ�watermaked Img

% ���룺hotst_image---����ͼ��
% ���룺wImg---ˮӡͼ��
% ���룺s1---shearlet�任����
% ���룺block_size---�ֿ��С
% ���룺lambda---ˮӡǶ��ǿ��
% ���룺wname---С���任С����
% ���룺n,a,b---Arnold���Ҳ���

% �����watermarked_Img---Ƕ��ˮӡ���ͼ��
% �����psnr_32---Ƕ��ˮӡ���PSNR

% ---------------------------------------------------------
% s1=1  % shearlet�任���� block_size=8; % ���С lambda=25; % Ƕ��ǿ�ȵ�ȷ�� wname='db2'; % DWT�任С����
if nargin < 7
	n = 10;
	a=3;
	b=5; 
end
% ����������С��7���n,a,bĬ��ֵ��
thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wbImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
w_Img = dsh_arnold(wbImg,n,a,b); % ˮӡ���Ҵ��� n=10 a=3 b=5
% w_Img =logistic_permutation_swap(wbImg,0.5,3.9); % ˮӡ����

[n n] =size(w_Img); % ˮӡ�Ĵ�С 32*32

[ll,dst,shear_f,lpfilt,ch,cv,cd]=d_get_ll(host_image,s1,wname);  % grey scaleͼ�� shearlet�任��ȡ��Ƶ����1level-DWT��ȡLL����


ll_prim=d_embed_watermark2(ll,w_Img,block_size,lambda); % LL�������8*8�ֿ��ÿһ��ȡ��m1 m2 SVDȡ��S�����ֵ��Ƕ��ˮӡ����


watermarked_Img=d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd);  % ȡ��Ƕ��ˮӡ���ll_prim��任����ˮӡͼ��


% imwrite(watermarked_Img,'watermarkedImg.tiff'); % ��ˮӡͼ�񱣴�


psnr_32 = psnr(host_image,watermarked_Img); % ����PSNR
end