function [arnoldwImg] = dsh_arnold(wImg,inp_n,inp_a,inp_b)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 本函数用于进行arnold置乱

% 输入：wImg---需要置乱的图像
% 输入：inp_n---置乱次数
% 输入：inp_a,inp_b---置乱参数
% 输出：arnoldwImg---Arnold置乱后的图像
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[h h]=size(wImg); % 得到输入图像的大小
% 设定参数
n=inp_n;
a=inp_a;
b=inp_b;
N=h;

% 置乱
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

