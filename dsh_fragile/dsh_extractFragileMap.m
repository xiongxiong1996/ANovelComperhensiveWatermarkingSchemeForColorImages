function [taggedImg,tmap] = dsh_extractFragileMap(wImg,block_size)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% �˷���������ȡ����ˮӡ��������һ��tmap�۸�ͼ�����ں������acc��

% ���룺wImg---����ȡ��ͼ��
% ���룺block_size---�ֿ��С
% �����taggedImg---�۸ı��ͼ��

% ---------------------------------------------------------
taggedImg = wImg;
[L L n] = size(wImg);
tmap = zeros(L,L);
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
		temp_block = imcrop(wImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% �ȶ� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		[istag] = dsh_lsbExtract(mb,hash_sequence);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% ��� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		if(istag==1)
			taggedImg(y1:y2,x1:x2)=1;
			tmap(y1:y2,x1:x2)=1;
		end
	end % for
end % 

end

