function [istag] = dsh_lsbExtract(mb,hash_sequence)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现脆弱水印嵌入

% 输入：mb---准备提取水印的层。
% 输入：hash_sequence---需要对比的hash序列
% 输出：istag---是否完全相同，如果提取的和计算的hash序列完全相同，则为1，否则为0

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

