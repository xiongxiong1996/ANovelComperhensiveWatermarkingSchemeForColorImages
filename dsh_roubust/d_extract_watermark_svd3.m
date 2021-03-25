function [w_b] = d_extract_watermark_svd3(m_matrix,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ��³��ˮӡ��ȡ
% SVD�о���Ƕ��ϸ��

% ���룺m_matrix---����ȡˮӡ��С��
% ���룺dt---ˮӡǶ�벽��
% �����w_b---��ȡ����ˮӡֵ
% ------------------------------------------------------------------

[U,S,V] = svd(m_matrix); % ����SVD
L_prim=S(1,1); % ��ȡS(1,1) ����ˮӡ��ȡ
sigma=mod(L_prim,dt); % ����mod����ȡ��sigma

% ͨ��sigma�ķ�Χȷ����ȡ������ˮӡbitֵ
if sigma < 1/2*dt
	w_b=0;
else
	w_b=1;
end
end

