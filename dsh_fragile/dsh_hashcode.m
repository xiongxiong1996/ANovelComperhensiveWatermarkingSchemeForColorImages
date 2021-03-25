function [hash_sequence] = dsh_hashcode(rwImg_r,fwImg_b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 该方法用于生成hash编码，已嵌入鲁棒水印和脆弱水印的子带一起生成嵌入编码

% 输入：rwImg_r---需要生成hash编码的层1
% 输入：rwImg_b---需要生成hash编码的层2
% 输出：hash_sequence---两层生成的编码融合产生的hash序列256位

% ---------------------------------------------------------

SHA256_1 = hash(rwImg_r,'SHA256');
SHA256_2 = hash(fwImg_b,'SHA256');
% c1=hex2dec(SHA256_1) ;
% b1=dec2bin(c1);
% c2=hex2dec(SHA256_2) ;
% b2=dec2bin(c2);
hash_sequence1 = get_hash_sequence(SHA256_1,'MD5');
hash_sequence2 = get_hash_sequence(SHA256_2,'MD5');

hash_sequence = zeros(1,256);
for n=1:256
	hash_sequence(n)=xor(hash_sequence1(n),hash_sequence2(n));
end
end

