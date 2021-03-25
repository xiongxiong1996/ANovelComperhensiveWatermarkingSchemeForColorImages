function [m_matrix_prim] = d_embed_watermark_svd3(m_matrix,w_b,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现鲁棒水印嵌入
% SVD中具体嵌入细节

% 输入：m_matrix---分块后，带嵌入的小块矩阵
% 输入：w_b---需要嵌入的水印值
% 输入：dt---水印嵌入步长
% 输出：m_matrix_prim---嵌入完水印的小块矩阵
% ------------------------------------------------------------------

[U,S,V] = svd(m_matrix); % 对矩阵进行SVD变换得到USV矩阵。

L=S(1,1); % 取S(1,1)用于嵌入
sigma=mod(L,dt); % 使用mod函数取得sigma（提取时，会根据不同的范围来判断嵌入水印的信息）
% 进行嵌入，根据要嵌入水印信息的不同，使用不同的公式
if w_b==0
	if sigma<(3*dt)/4
		L_prim=L-sigma+dt/4;
	else
		L_prim=L-sigma+(5*dt)/4;
	end
else
	if sigma<dt/4
		L_prim=L-sigma-dt/4;
	else
		L_prim=L-sigma+(3*dt)/4;
	end
end
% 嵌入完毕后进行逆变换
S(1,1)=L_prim;
m_matrix_prim=U*S*V';
 
% m_matrix_prim-m_matrix;
end

