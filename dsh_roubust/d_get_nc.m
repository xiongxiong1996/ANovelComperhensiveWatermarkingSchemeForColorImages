function [nc] = d_get_nc(ImageA,ImageB)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实验测试时使用，获取NC值

% 输入：ImageA，ImageB---需要进行比较的两个图片
% 输出：nc---两个图片的BER值

% ---------------------------------------------------------
if (size(ImageA,1)~=size(ImageB,1))or(size(ImageA,2)~=size(ImageB,2))
	error('ImageA<>ImageB');
	nc=0;
	return;
end
ImageA=double(ImageA);
ImageB=double(ImageB);
[M,N]=size(ImageA);
d1=0;
d2=0;
d3=0;
for i=1:M
	for j=1:N
		d1=d1+ImageA(i,j)*ImageB(i,j);
		d2=d2+ImageA(i,j)*ImageA(i,j);
		d3=d3+ImageB(i,j)*ImageB(i,j);
	end
end
nc=d1/(sqrt(d2)*sqrt(d3));
end