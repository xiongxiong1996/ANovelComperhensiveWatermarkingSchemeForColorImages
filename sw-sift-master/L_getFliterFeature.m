% 
%   Copyright (C) 2020 Liu yunpeng <yunpeng2000china@gmail.com>
% 
%   ���������ڶ�ͼ������Ĳ����ֽ⣬����ÿһ�����У���ѡȡһ�������㡣

function [fdes,floc] = L_getFliterFeature(img,des,loc,n)
% ����ΪͼƬ�����Ӧ������ֵ
% ���ΪͼƬɸѡ�������ֵ
img_gray= rgb2gray(img);% תΪ�Ҷ�ͼ��
S = qtdecomp(img_gray,.27,8);% �ֿ鴦��
S=full(S);            % תΪȫ����
[Sr,Sc] = size(S);    % ��ȡS���󳤿�
[Lr,Lc] = size(loc);  % ��ȡloc���󳤿�
ftdes=zeros(size(des));% ����ɸѡ���des����
ftloc=zeros(size(loc));% ����ɸѡ���loc����
index=0;              % ��ʼ������������
 for i = 1:Sr        % ����forѭ��Ƕ��
    for j = 1:Sc
        if S(i,j) ~= 0  % ��ȡ����ÿ��λ�����ݣ����к���
           count=0;  %��ʼ��ÿ�����ͳ�ƣ�
           for k=1:Lr
               if loc(k,2)>=i && loc(k,2)<S(i,j)+i && loc(k,1)>=j && loc(k,1)<S(i,j)+j% ���������Ҫ��(i,i+S��i,j),j,j+S��i,j))֮��
                   index=index+1;        % ������������1 
                   count=count+1;       % ������1
                   ftdes(index,:)=des(k,:); % ������ʱdes
                   ftloc(index,:)=loc(k,:); % ������ʱloc
                   if(count>n-1)% ����Ϊ1 ����ѭ��
                       break
                   end
               end
           end
        end
    end
 end
fdes=zeros(index,128);% ����ɸѡ���des����
floc=zeros(index,2);% ����ɸѡ���loc����
fdes=ftdes(1:index,:);
floc=ftloc(1:index,:);
