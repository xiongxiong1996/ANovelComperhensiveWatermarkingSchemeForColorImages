function [fw_martrix] = dsh_lsbEmbed(Img,hash_sequence)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% �÷�������LSBǶ��ˮӡ

% ���룺Img---��Ƕ���ͼ��
% ���룺hash_sequence---hash����
% �����fw_martrix---Ƕ����ϵ�ͼ��

% ---------------------------------------------------------
[L L]=size(Img);
n=1;
fw_martrix=Img;
% ������Ƕ��hash_sequence
for i=1:L
	for j=1:L
		p = Img(i,j);
		b7 = floor(p/2)*2;
		if hash_sequence(n) == 1
			b=b7+1;
			n=n+1;
		else
			b=b7;
			n=n+1;
		end
		fw_martrix(i,j)=b;
	end
end
end

