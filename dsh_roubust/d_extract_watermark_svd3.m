function [w_b] = d_extract_watermark_svd3(m_matrix,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现鲁棒水印提取
% SVD中具体嵌入细节

% 输入：m_matrix---带提取水印的小块
% 输入：dt---水印嵌入步长
% 输出：w_b---提取出的水印值
% ------------------------------------------------------------------

[U,S,V] = svd(m_matrix); % 进行SVD
L_prim=S(1,1); % 获取S(1,1) 用于水印提取
sigma=mod(L_prim,dt); % 根据mod函数取得sigma

% 通过sigma的范围确定提取出来的水印bit值
if sigma < 1/2*dt
	w_b=0;
else
	w_b=1;
end
end

