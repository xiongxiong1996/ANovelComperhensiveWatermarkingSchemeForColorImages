% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% ��ʵ�������ҵ����ʺϵ�lambda��dt����Ƕ�롣
% ���ɵ����ݻ�浽excel�У����ڻ���PSNRͼ�õ����ݼ��Ӵ˴�����
clear
tic
% ����ͼ���ȡ
hostImage = imread('lena512color.tiff'); 
% ����ˮӡͼ�� 
wImg=imread('wImg32.png'); % ����ˮӡͼ��

thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wbImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
ow_Img=wbImg;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      ��������    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet�任����
block_size1=8; % ³��ˮӡ1 �ֿ��С
block_size2=4; % ³��ˮӡ2 �ֿ��С
block_size3=16; % ����ˮӡ �ֿ��С
wname='db2'; % ³��ˮӡ1 2 DWT�任С����
img_border=5; % ��ת������Ե�ճ����





% ������ͼ����зֲ�
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
		% %%%%%%%%%%%%%%%%%%%%%%%%%    ˮӡ1Ƕ��   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		w1 = dsh_embed2(ht1,wImg,s1,block_size1,lambda,wname); % ����ˮӡǶ�뷽����Ƕ��³��ˮӡ1
		watermarkedImg(:,:,1) = w1; % ʹ��Ƕ��ˮӡ���R���滻ˮӡͼ���е�R��
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%    ˮӡ2Ƕ��   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		w2 = dsh_embed3(ht2,wImg,s1,block_size2,dt,wname); % ����ˮӡǶ�뷽����Ƕ��³��ˮӡ2
		watermarkedImg(:,:,2) = w2; % ʹ��Ƕ��ˮӡ���R���滻ˮӡͼ���е�G��
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%    ˮӡ3Ƕ��   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		watermarkedImg = dsh_embedFragileW(watermarkedImg,block_size3); % ����ˮӡǶ�뷽����Ƕ�����ˮӡ�����������Ƕ��³��ˮӡ���ͼ�񣬷ֿ��С
		% �����������
		psnr_32 = psnr(hostImage,watermarkedImg); % ����PSNR
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