function [ f ] = Decrypt_logistic_permutation_swap(Scambled,x1,mu)
% UNTITLED5 �˴���ʾ�йش˺�����ժҪ
% ���������ڶ�ͼ�����logistic���ҽ���
%   �˴���ʾ��ϸ˵��
[m,n]=size(Scambled);
p(1)=x1;
for i=1:m*n+999
    p(i+1)=mu*p(i)*(1-p(i));
end
p=p(1001:length(p));            % ȥ��ǰ1000�㣬��ø��õ������
[b,num]=sort(p);
f=uint8(zeros(m,n));
for i=m*n:-1:1            % i��m*n��1�������
    a=Scambled(i);
    Scambled(i)=Scambled(num(i));
    Scambled(num(i))=a;
end
f=Scambled;
end