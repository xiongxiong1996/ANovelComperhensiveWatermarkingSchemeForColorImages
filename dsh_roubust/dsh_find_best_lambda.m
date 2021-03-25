% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% �����������ҵ���ѵ�lambdaֵ��ˮӡ³���Ժ�PSNR

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%      ˮӡ����ͼ����    %%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
host_image= imread('lena512.pgm'); % ��������ͼ��
wImg=imread('wImg32.png'); % ����ˮӡͼ��

thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wbImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
ow_Img=wbImg;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      ��������    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet�任����
block_size=8; % ���С
wname='db2'; % DWT�任С����

a_list=zeros(30,3);
for lambda=1:30
	[watermarked_Img,psnr_32] = dsh_embed2(host_image,wImg,s1,block_size,lambda,wname);
	[avg_nc] = dsh_get_avgnc2(watermarked_Img,ow_Img,s1,block_size,wname);
	a_list(lambda,1)=lambda;
	a_list(lambda,2)=psnr_32;
	a_list(lambda,3)=avg_nc;
end
