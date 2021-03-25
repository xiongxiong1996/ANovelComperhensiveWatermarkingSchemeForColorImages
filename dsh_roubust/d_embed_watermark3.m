function [ll_prim] = d_embed_watermark3(ll,w_Img,block_size,dt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现鲁棒水印嵌入
% 分块DCT+SVD两个矩阵进行鲁棒水印嵌入

% 输入：ll---低频子带(使用shearlet中的低频子带，再取DWT后的低频子带)
% 输入：w_Img---需要嵌入的二值水印图像
% 输入：block_size---分块大小
% 输入：dt --- 水印嵌入步长
% 输出：ll_prim---嵌入完水印的低频子带

% ---------------------------------------------------------
[n n] =size(w_Img); % 获取水印图像的大小
w_squence=zeros(1,n*n); % 创建水印序列

% 填写水印序列
w_s_num=1;
for i=1:n
	for j=1:n
		w_squence(w_s_num)=w_Img(i,j);
		w_s_num=w_s_num+1;
	end
end

[L L]=size(ll); % 获取低频子带大小
% %%%%%%%%%%%%%%%%%%
% %%%%%% 分块 %%%%%%
% %%%%%%%%%%%%%%%%%%
w_s_num=1; % 水印序列序号
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		m_matrix = zeros(block_size,block_size); % 生成分块大小的matrix
		% %%%%%%%%%%%%%%%
		% %给matrix填值 %
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
		% %%%%%% 嵌入 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		m_matrix_prim = d_embed_watermark_svd3(m_matrix,w_squence(w_s_num),dt);
		ll(x1:x2,y1:y2)=m_matrix_prim;
		w_s_num=w_s_num+1;
	end % for
end % for
ll_prim=ll;
end

