function [taggedImg,tmap] = dsh_extractFragileMap(wImg,block_size)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 此方法用于提取脆弱水印，并产生一个tmap篡改图，用于后面计算acc等

% 输入：wImg---待提取的图像
% 输入：block_size---分块大小
% 输出：taggedImg---篡改标记图像

% ---------------------------------------------------------
taggedImg = wImg;
[L L n] = size(wImg);
tmap = zeros(L,L);
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
		temp_block = imcrop(wImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% 比对 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		[istag] = dsh_lsbExtract(mb,hash_sequence);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% 标记 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		if(istag==1)
			taggedImg(y1:y2,x1:x2)=1;
			tmap(y1:y2,x1:x2)=1;
		end
	end % for
end % 

end

