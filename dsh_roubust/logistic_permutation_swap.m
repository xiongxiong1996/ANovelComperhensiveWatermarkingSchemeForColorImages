function [Scambled]=logistic_permutation_swap(f,x1,mu)
% UNTITLED5 �˴���ʾ�йش˺�����ժҪ
% ���������ڶ�ͼ�����logistic����
%   �˴���ʾ��ϸ˵��
[m,n]=size(f);
% ������������
x=zeros(m*n+999,1);
x(1)=x1;
for i=1:m*n+999
    x(i+1)=mu*x(i)*(1-x(i));
end
x=x(1001:length(x));
[~,num]=sort(x);% �������Ļ������н�������

Scambled=uint8(zeros(m,n));% ����һ����ԭͼ��С��ͬ��0����
for i=1:m*n
    a=f(i);
    f(i)=f(num(i));
    f(num(i))=a;
end
Scambled=f;
end