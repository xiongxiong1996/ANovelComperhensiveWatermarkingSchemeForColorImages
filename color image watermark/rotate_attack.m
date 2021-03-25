function [att] = rotate_attack(wImg,watermarkedImg,des1,loc1,s1,block_size1,block_size2,wname,dt,n)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% RATION_ATTACK Summary of this function goes here
% % ���������ڲ�����ת������ˮӡ1 2 ��³����
%   Detailed explanation goes here
thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
ow_Img=wImg;


% watermarkedImg = imrotate(watermarkedImg,-20,'crop');
att_n=0;
att=zeros(35,7); % ���ڴ�Ź�����ͼ���³������Ϣ
for i=1:11
		% ������ת����
		watermarkedImg_r = imrotate(watermarkedImg,-i*15,'crop');
		% ��ת����
		[recover_img,angle,avgAngle] = d_reoverRotation(des1,loc1,watermarkedImg_r);
		% ��ȡˮӡw1������ber��ncֵ
		extract_w1 = dsh_extract2(recover_img(:,:,1),s1,block_size1,wname,32);
		ber1=d_get_ber(ow_Img,extract_w1);
		nc_num1=d_get_nc(ow_Img,extract_w1);
		% ��ȡˮӡw2������ber��ncֵ
		extract_w2 =dsh_extract3(recover_img(:,:,2),s1,block_size2,wname,dt,32); 
		ber2=d_get_ber(ow_Img,extract_w2);
		nc_num2=d_get_nc(ow_Img,extract_w2);
		% psnr_w=psnr(ow_Img,extract_w);
		att(i,1)=i-1;
    att(i,2)=ber1;
    att(i,3)=nc_num1;
    att(i,4)=ber2;
    att(i,5)=nc_num2;
    att(i,6)=-i*15;
    att(i,7)=avgAngle;
		att_n=att_n+1;
end
end

