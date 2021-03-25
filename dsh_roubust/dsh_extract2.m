function [extract_w] = dsh_extract2(watermarked_Img,s1,block_size,wname,n,an,a,b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ˮӡ2��������ȡ����

% ���룺watermarked_Img---��ˮӡͼ��
% ���룺s1---shearlet�任����
% ���룺block_size---�ֿ��С
% ���룺wname---С���任С����
% ���룺n---ˮӡͼ���С
% ���룺na,a,b---Arnold���Ҳ���
% �����extract_w---��ȡ���ˮӡͼ��

% ---------------------------------------------------------
if nargin < 6
	an = 10;
	a=3;
	b=5;
end
% ����������С��7���n,a,bĬ��ֵ��
[dst,shear_f,lpfilt] = dsh_shearletTransform(watermarked_Img,s1,0);
dst1=dst{1};
% ca = LL 
[ca ch cv cd] = dwt2(dst1,wname);

ll_prim=ca;



w_squence=zeros(1,n*n);
w_s_num=1;


[L L]=size(ll_prim);
% %%%%%%%%%%%%%%%%%%
% %%%%%% �ֿ� %%%%%%
% %%%%%%%%%%%%%%%%%%
w_s_num=1; % ˮӡ�������
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		m_matrix = zeros(block_size,block_size); % ����block_size��С��matrix
		% %%%%%%%%%%%%%%%
		% %��matrix��ֵ %
		% %%%%%%%%%%%%%%%
		m_w=1;
		for r=x1:x2
			m_h=1;
			for l=y1:y2
				m_matrix(m_w,m_h)=ll_prim(r,l);
				m_h=m_h+1;
			end % for
			m_w=m_w+1;
		end % for
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% ��ȡ %%%%%%
		% %%%%%%%%%%%%%%%%%%
		m_matrix = dct2(m_matrix); % dct�任
		w_b = d_extract_watermark_svd2(m_matrix);
		w_squence(w_s_num)=w_b;
		w_s_num=w_s_num+1;
	end % for
end % for


extract_w=zeros(n,n);
w_s_num=1;
for i=1:n
	for j=1:n
		extract_w(i,j)=w_squence(w_s_num);
		w_s_num=w_s_num+1;
	end
end

extract_w = dsh_inverseArnold(extract_w,an,a,b);
% extract_w = Decrypt_logistic_permutation_swap(extract_w,0.5,3.9); % ���һָ�
end
