function [fwcImg] = dsh_embedFragileW(rwImg,block_size)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ�ִ���ˮӡǶ��

% ���룺rwImg---׼��Ƕ�����ˮӡ��ͼ�񣬴˴�Ϊ�����ɫͼ��
% ���룺block_size---�ֿ��С
% �����fwcImg---Ƕ����ϵ�ͼ�񣬴˴�ҲΪ�����ɫͼ��

% ---------------------------------------------------------

fwcImg=rwImg;
fwImg=rwImg(:,:,3);
% �ֿ�
[L L n] = size(rwImg);
% %%%%%%%%%%%%%%%%%%
% %%%%%% �ֿ� %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%
		% %%%  ����hash  %%%
		% %%%%%%%%%%%%%%%%%%
		temp_block = imcrop(rwImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% Ƕ�� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		% LSBǶ��
		mb=temp_block(:,:,3); % B
		[fw_martrix] = dsh_lsbEmbed(mb,hash_sequence);
		% �滻ԭ���Ŀ�
		fwImg(y1:y2,x1:x2)=fw_martrix;
	end % for
end % 

fwcImg(:,:,3)=fwImg;
end

