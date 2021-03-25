function [angle] = getAngle(a1,a2,b1,b2)
% 
%   Copyright (C) 2020 Duan shaohua <smartJack1996@gmail.com>
% 
% GETANGLE Summary of this function goes here
% ������������֮��ļн�
%   Detailed explanation goes here
% ���� a1,a2---����a�ĵ�
% ���� b1,b2---����b�ĵ�
a = a1-a2;
b = b1-b2;
temp = (a(1).*b(1)+a(2).*b(2))/(sqrt(a(1).*a(1)+a(2).*a(2)).*sqrt(b(1).*b(1)+b(2).*b(2)));
angle = acos(temp)/pi*180;
end

