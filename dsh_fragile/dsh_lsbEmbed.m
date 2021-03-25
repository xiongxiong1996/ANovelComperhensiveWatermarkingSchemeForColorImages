function [fw_martrix] = dsh_lsbEmbed(Img,hash_sequence)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 该方法用于LSB嵌入水印

% 输入：Img---待嵌入的图像
% 输入：hash_sequence---hash序列
% 输出：fw_martrix---嵌入完毕的图像

% ---------------------------------------------------------
[L L]=size(Img);
n=1;
fw_martrix=Img;
% 遍历，嵌入hash_sequence
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

