function [ber] = d_get_ber(img1,img2)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实验测试时使用，获取BER值

% 输入：img1，img2---需要进行比较的两个图片
% 输出：ber---两个图片的BER值

% ---------------------------------------------------------
[n n]=size(img1);
squence1=zeros(1,n*n); % 创建序列
squence2=zeros(1,n*n);
% 填写序列
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

