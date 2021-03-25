function [att] = dsh_attact_test2(wImg,watermarkedImg,s1,block_size,wname,n)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ��������1�����ڲ���1������³����

% ���룺wImg---ˮӡͼ�����ڽ��бȽϣ�NCֵ��BERֵ����
% ���룺watermarkedImg---Ƕ��ˮӡ���ͼ���
% ���룺s1---shearlet�任����
% ���룺block_size---ˮӡ�����ֿ��С
% ���룺wname---DWT�任С����
% ���룺n---ˮӡͼ���С�����������
% �����att---�������ֹ������list

% ---------------------------------------------------------

% ���ֹ�������
% ow_Img=dsh_extract2(watermarkedImg,s1,block_size,wname,n); % ��ȡδ�չ�����ˮӡ
thresh =graythresh(wImg);     % �Զ�ȷ����ֵ����ֵ
wImg = im2bw(wImg,thresh);   % ��ͼ���ֵ��
ow_Img=wImg;
att_n=0;
att=zeros(76,3); % ���ڴ�Ź�����ͼ���³������Ϣ
for i=1:77
		[attacked_img,att_name] = attacks(watermarkedImg,att_n); % ���ù�������
		extract_w=dsh_extract2(attacked_img,s1,block_size,wname,n); 
		ber=d_get_ber(ow_Img,extract_w);
		nc_num=d_get_nc(ow_Img,extract_w);
		% psnr_w=psnr(ow_Img,extract_w);
		% figure(i);
		% imshow(extract_w);
		att(i,1)=i-1;
    att(i,2)=ber;
    att(i,3)=nc_num;
		att_n=att_n+1;
end

end

