function [w_b] = d_extract_watermark_svd2(m_matrix)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现鲁棒水印提取
% SVD中具体嵌入细节

% 输入：m_matrix---带提取水印的小块
% 输出：w_b---提取出的水印值
% ------------------------------------------------------------------


m1=zeros(2,2);
m2=zeros(2,2);

m1(1,1)=m_matrix(2,5);
m1(1,2)=m_matrix(4,3);
m1(2,1)=m_matrix(6,2);
m1(2,2)=m_matrix(4,4);

m2(1,1)=m_matrix(3,4);
m2(1,2)=m_matrix(5,2);
m2(2,1)=m_matrix(5,3);
m2(2,2)=m_matrix(3,5);

[U1,S1,V1] = svd(m1);

[U2,S2,V2] = svd(m2);

x=S1(1,1);
y=S2(1,1);

if x > y
	w_b=1;
else
	w_b=0;
end
end

