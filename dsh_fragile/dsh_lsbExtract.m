function [istag] = dsh_lsbExtract(mb,hash_sequence)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ�ִ���ˮӡǶ��

% ���룺mb---׼����ȡˮӡ�Ĳ㡣
% ���룺hash_sequence---��Ҫ�Աȵ�hash����
% �����istag---�Ƿ���ȫ��ͬ�������ȡ�ĺͼ����hash������ȫ��ͬ����Ϊ1������Ϊ0

% ---------------------------------------------------------
tagBlock_n=0;
seq_n=1;
istag=0;
[L L]= size(mb);
for n=1:L
		for m=1:L
			p = mb(n,m);
			w = mod(p,2);
			if w == hash_sequence(seq_n)
				seq_n=seq_n+1;
			else
				tagBlock_n=tagBlock_n+1;
			end
		end
end
if tagBlock_n>0
	istag=1;
end
end

