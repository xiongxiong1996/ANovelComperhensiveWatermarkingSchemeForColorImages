% ����ʵ��SVD��äˮӡ����3����������
% f1.grey scaleͼ�� shearlet�任��ȡ��Ƶ����1level-DWT��ȡLL����
% f2.LL�������4*4�ֿ� ȡ��S�����ֵ��Ƕ��ˮӡ����
% f3.LL'���������任�õ�watermaked Img
% % shearlet DWT  SVD Ƕ��

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%      ˮӡ����ͼ����    %%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
host_image= imread('lena512.pgm'); % ��������ͼ��
% host_image= imread('man.tiff'); % ��������ͼ��
% host_image= imread('peppers.tiff'); % ��������ͼ��
wImg=imread('wImg32.png'); % ����ˮӡͼ��


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%      ��������    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet�任����
block_size=4; % ���С
dt=85; % Ƕ��ǿ�ȵ�ȷ��
wname='db2'; % DWT�任С����

[watermarked_Img,psnr_32] = dsh_embed3(host_image,wImg,s1,block_size,dt,wname)

imwrite(watermarked_Img,'watermarkedImg.tiff'); % ��ˮӡͼ�񱣴�

psnr_32 = psnr(host_image,watermarked_Img); % ����PSNR

[extract_w] = dsh_extract3(watermarked_Img,s1,block_size,wname,dt,32) % ��ˮӡͼ������ȡˮӡ

[att] = dsh_attact_test3(wImg,watermarked_Img,s1,block_size,wname,dt,32);
% [att] = dsh_attact_test(wImg,watermarked_Img,s1,block_size,wname,32);