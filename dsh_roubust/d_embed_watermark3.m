function [ll_prim] = d_embed_watermark3(ll,w_Img,block_size,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ��³��ˮӡǶ��
% �ֿ�DCT+SVD�����������³��ˮӡǶ��

% ���룺ll---��Ƶ�Ӵ�(ʹ��shearlet�еĵ�Ƶ�Ӵ�����ȡDWT��ĵ�Ƶ�Ӵ�)
% ���룺w_Img---��ҪǶ��Ķ�ֵˮӡͼ��
% ���룺block_size---�ֿ��С
% ���룺dt --- ˮӡǶ�벽��
% �����ll_prim---Ƕ����ˮӡ�ĵ�Ƶ�Ӵ�

% ---------------------------------------------------------
[n n] =size(w_Img); % ��ȡˮӡͼ��Ĵ�С
w_squence=zeros(1,n*n); % ����ˮӡ����

% ��дˮӡ����
w_s_num=1;
for i=1:n
	for j=1:n
		w_squence(w_s_num)=w_Img(i,j);
		w_s_num=w_s_num+1;
	end
end

[L L]=size(ll); % ��ȡ��Ƶ�Ӵ���С
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
		m_matrix = zeros(block_size,block_size); % ���ɷֿ��С��matrix
		% %%%%%%%%%%%%%%%
		% %��matrix��ֵ %
		% %%%%%%%%%%%%%%%
		m_w=1;
		for r=x1:x2
			m_h=1;
			for l=y1:y2
				m_matrix(m_w,m_h)=ll(r,l);
				m_h=m_h+1;
			end % for
			m_w=m_w+1;
		end % for
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% Ƕ�� %%%%%%
		% %%%%%%%%%%%%%%%%%%
		m_matrix_prim = d_embed_watermark_svd3(m_matrix,w_squence(w_s_num),dt);
		ll(x1:x2,y1:y2)=m_matrix_prim;
		w_s_num=w_s_num+1;
	end % for
end % for
ll_prim=ll;
end

