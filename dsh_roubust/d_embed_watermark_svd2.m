function [m_matrix_prim] = d_embed_watermark_svd2(m_matrix,w_b,lambda)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ��³��ˮӡǶ��
% SVD�о���Ƕ��ϸ��

% ���룺m_matrix---�ֿ�󣬴�Ƕ���С�����
% ���룺w_b---��ҪǶ���ˮӡֵ
% ���룺lambda---ˮӡǶ��ǿ��
% �����m_matrix_prim---Ƕ����ˮӡ��С�����

% ---------------------------------------------------------
			
m_matrix = dct2(m_matrix); % DCT2�任		
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
E=(x+y)/2;


if w_b==0
	x=E-lambda;
	y=E+lambda;
else
	x=E+lambda;
	y=E-lambda;
end
S1(1,1)=x;
S2(1,1)=y;
m1=U1*S1*V1';
m2=U2*S2*V2';

m_matrix(2,5)=m1(1,1);
m_matrix(4,3)=m1(1,2);
m_matrix(6,2)=m1(2,1);
m_matrix(4,4)=m1(2,2);
    
m_matrix(3,4)=m2(1,1);
m_matrix(5,2)=m2(1,2);
m_matrix(5,3)=m2(2,1);
m_matrix(3,5)=m2(2,2);

m_matrix_prim=m_matrix;
m_matrix_prim = idct2(m_matrix_prim); % IDCT2�任
end

