function [avg_nc] = dsh_get_avgnc2(watermarked_Img,ow_Img,s1,block_size,wname)
% D_GET_AVGNC2 Summary of this function goes here
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% ���������ڲ���ˮӡw1,��ȡƽ��NCֵ��ƽ��NCֵΪ
% Image brighten  
% Image darken
% Average filter 3X3
% Median filter 3X3
% Motion filter 3X3
% Scaling 0.5
% ������ƽ��ֵ
%   Detailed explanation goes here
att=zeros(6,3); % ���ڴ�Ź�����ͼ���³������Ϣ
att_array=[11,12,29,34,39,66];
att_n=1;
for i=1:6
	[attacked_img,att_name] = attacks(watermarked_Img,att_array(att_n)); % ���ù�������
	extract_w=dsh_extract2(attacked_img,s1,block_size,wname,32); 
	ber=d_get_ber(ow_Img,extract_w);
	nc_num=d_get_nc(ow_Img,extract_w);
	att(i,1)=i-1;
	att(i,2)=ber;
	att(i,3)=nc_num;
	att_n=att_n+1;
end
sum_nc=0;
for j=1:6
	sum_nc=sum_nc+att(j,3);
end
avg_nc=sum_nc/6;
end

