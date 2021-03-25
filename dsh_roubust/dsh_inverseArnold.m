function [wImg] = dsh_inverseArnold(arnoldwImg,inp_n,inp_a,inp_b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% Arnold���ҵ��淽��

% ���룺arnoldwImg---Arnold���Һ��ͼ��
% ���룺inp_n,inp_a,inp_b---Arnold���Ҳ���
% �����wImg---�ָ����ͼ��
% ---------------------------------------------------------
% ��ԭ
[h h]=size(arnoldwImg);
n=inp_n;
a=inp_a;
b=inp_b;
N=h;
img=arnoldwImg;
for i=1:n
    for y=1:h
        for x=1:h            
            xx=mod((a*b+1)*(x-1)-b*(y-1),N)+1;
            yy=mod(-a*(x-1)+(y-1),N)+1  ;        
            arnoldwImg(yy,xx)=img(y,x);                   
        end
    end
    img=arnoldwImg;
end
wImg=arnoldwImg;
end

