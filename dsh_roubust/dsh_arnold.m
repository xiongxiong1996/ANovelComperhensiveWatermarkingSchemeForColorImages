function [arnoldwImg] = dsh_arnold(wImg,inp_n,inp_a,inp_b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ���������ڽ���arnold����

% ���룺wImg---��Ҫ���ҵ�ͼ��
% ���룺inp_n---���Ҵ���
% ���룺inp_a,inp_b---���Ҳ���
% �����arnoldwImg---Arnold���Һ��ͼ��
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h h]=size(wImg); % �õ�����ͼ��Ĵ�С
% �趨����
n=inp_n;
a=inp_a;
b=inp_b;
N=h;

% ����
imgn=zeros(h,h);
for i=1:n
    for y=1:h
        for x=1:h          
            xx=mod((x-1)+b*(y-1),N)+1;
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            imgn(yy,xx)=wImg(y,x);                
        end
    end
    wImg=imgn;
end
arnoldwImg=wImg;
end

