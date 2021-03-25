function [Scambled]=logistic_permutation_swap(f,x1,mu)
% UNTITLED5 此处显示有关此函数的摘要
% 本函数用于对图像进行logistic置乱
%   此处显示详细说明
[m,n]=size(f);
% 产生混沌序列
x=zeros(m*n+999,1);
x(1)=x1;
for i=1:m*n+999
    x(i+1)=mu*x(i)*(1-x(i));
end
x=x(1001:length(x));
[~,num]=sort(x);% 将产生的混沌序列进行排序

Scambled=uint8(zeros(m,n));% 产生一个与原图大小相同的0矩阵
for i=1:m*n
    a=f(i);
    f(i)=f(num(i));
    f(num(i))=a;
end
Scambled=f;
end