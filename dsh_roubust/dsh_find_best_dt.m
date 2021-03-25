% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% �����������ҵ�dt�����ֵ���ٱ�֤ˮӡ������ͬʱ�����PSNR

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
block_size=4; % ���С
wname='db2'; % DWT�任С����

dt=85; % Ƕ��ǿ�ȵ�ȷ��
a_list=zeros(50,3);
for dt=1:4:117
	[watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname);
	[avg_nc] = dsh_get_avgnc3(watermarked_Img,ow_Img,s1,block_size,wname,dt);
	a_list(floor(dt/4)+1,1)=dt;
	a_list(floor(dt/4)+1,2)=psnr_32;
	a_list(floor(dt/4)+1,3)=avg_nc;
end
