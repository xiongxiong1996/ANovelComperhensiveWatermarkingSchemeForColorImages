function [ber] = d_get_ber(img1,img2)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ʵ�����ʱʹ�ã���ȡBERֵ

% ���룺img1��img2---��Ҫ���бȽϵ�����ͼƬ
% �����ber---����ͼƬ��BERֵ

% ---------------------------------------------------------
[n n]=size(img1);
squence1=zeros(1,n*n); % ��������
squence2=zeros(1,n*n);
% ��д����
s_num=1;
for i=1:n
	for j=1:n
		squence1(s_num)=img1(i,j);
		squence2(s_num)=img2(i,j);
		s_num=s_num+1;
	end
end
count=0;
s_num=1;
for i=1:n*n
	if squence1(s_num) ~= squence2(s_num)
		count=count+1;
	end
	s_num=s_num+1;
end
ber=count/(n*n);
end

