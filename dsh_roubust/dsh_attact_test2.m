function [att] = dsh_attact_test2(wImg,watermarkedImg,s1,block_size,wname,n)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 攻击测试1，用于测试1方案的鲁棒性

% 输入：wImg---水印图像，用于进行比较，NC值，BER值计算
% 输入：watermarkedImg---嵌入水印后的图像层
% 输入：s1---shearlet变换级数
% 输入：block_size---水印方案分块大小
% 输入：wname---DWT变换小波名
% 输入：n---水印图像大小（多余参数）
% 输出：att---经过各种攻击后的list

% ---------------------------------------------------------

% 各种攻击测试
% ow_Img=dsh_extract2(watermarkedImg,s1,block_size,wname,n); % 提取未收攻击的水印
thresh =graythresh(wImg);     % 自动确定二值化阈值
wImg = im2bw(wImg,thresh);   % 对图像二值化
ow_Img=wImg;
att_n=0;
att=zeros(76,3); % 用于存放攻击后图像的鲁棒性信息
for i=1:77
		[attacked_img,att_name] = attacks(watermarkedImg,att_n); % 调用攻击函数
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

