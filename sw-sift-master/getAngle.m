function [angle] = getAngle(a1,a2,b1,b2)
% 
%   Copyright (C) 2020 Duan shaohua <smartJack1996@gmail.com>
% 
% GETANGLE Summary of this function goes here
% 计算两个向量之间的夹角
%   Detailed explanation goes here
% 输入 a1,a2---向量a的点
% 输入 b1,b2---向量b的点
a = a1-a2;
b = b1-b2;
temp = (a(1).*b(1)+a(2).*b(2))/(sqrt(a(1).*a(1)+a(2).*a(2)).*sqrt(b(1).*b(1)+b(2).*b(2)));
angle = acos(temp)/pi*180;
end

