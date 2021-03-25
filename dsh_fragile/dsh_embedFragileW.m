function [fwcImg] = dsh_embedFragileW(rwImg,block_size)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现脆弱水印嵌入

% 输入：rwImg---准备嵌入脆弱水印的图像，此处为三层彩色图像。
% 输入：block_size---分块大小
% 输出：fwcImg---嵌入完毕的图像，此处也为三层彩色图像

% ---------------------------------------------------------

fwcImg=rwImg;
fwImg=rwImg(:,:,3);
% 分块
[L L n] = size(rwImg);
% %%%%%%%%%%%%%%%%%%
% %%%%%% 分块 %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%
		% %%%  生成hash  %%%
		% %%%%%%%%%%%%%%%%%%
		temp_block = imcrop(rwImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% 嵌入 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		% LSB嵌入
		mb=temp_block(:,:,3); % B
		[fw_martrix] = dsh_lsbEmbed(mb,hash_sequence);
		% 替换原来的块
		fwImg(y1:y2,x1:x2)=fw_martrix;
	end % for
end % 

fwcImg(:,:,3)=fwImg;
end

