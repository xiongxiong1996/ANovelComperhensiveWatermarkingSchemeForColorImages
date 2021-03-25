function [ f ] = Decrypt_logistic_permutation_swap(Scambled,x1,mu)
% UNTITLED5 此处显示有关此函数的摘要
% 本函数用于对图像进行logistic置乱解码
%   此处显示详细说明
[m,n]=size(Scambled);
p(1)=x1;
for i=1:m*n+999
    p(i+1)=mu*p(i)*(1-p(i));
end
p=p(1001:length(p));            % 去除前1000点，获得更好的随机性
[b,num]=sort(p);
f=uint8(zeros(m,n));
for i=m*n:-1:1            % i从m*n到1逆序输出
    a=Scambled(i);
    Scambled(i)=Scambled(num(i));
    Scambled(num(i))=a;
end
f=Scambled;
end