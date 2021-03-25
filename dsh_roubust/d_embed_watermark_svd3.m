function [m_matrix_prim] = d_embed_watermark_svd3(m_matrix,w_b,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ��³��ˮӡǶ��
% SVD�о���Ƕ��ϸ��

% ���룺m_matrix---�ֿ�󣬴�Ƕ���С�����
% ���룺w_b---��ҪǶ���ˮӡֵ
% ���룺dt---ˮӡǶ�벽��
% �����m_matrix_prim---Ƕ����ˮӡ��С�����
% ------------------------------------------------------------------

[U,S,V] = svd(m_matrix); % �Ծ������SVD�任�õ�USV����

L=S(1,1); % ȡS(1,1)����Ƕ��
sigma=mod(L,dt); % ʹ��mod����ȡ��sigma����ȡʱ������ݲ�ͬ�ķ�Χ���ж�Ƕ��ˮӡ����Ϣ��
% ����Ƕ�룬����ҪǶ��ˮӡ��Ϣ�Ĳ�ͬ��ʹ�ò�ͬ�Ĺ�ʽ
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
% Ƕ����Ϻ������任
S(1,1)=L_prim;
m_matrix_prim=U*S*V';
 
% m_matrix_prim-m_matrix;
end

