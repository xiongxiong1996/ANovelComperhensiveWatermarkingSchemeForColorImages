function [watermarked_Img] = d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 本函数用于恢复恢复图像，实现逆变换，逆shearlet及DWT

% 输入：ll_prim,s1,wname,dst,shearf,lpfilt,ch,cv,cd ---各种用于恢复的参数
% 输出：w_Img---逆变换后得到的含有水印的图像

% ---------------------------------------------------------

dst1=idwt2(ll_prim,ch,cv,cd,wname);
dst{1}=dst1;
watermarked_Img = dsh_inverseShearletTransform(dst,shear_f,lpfilt);
end

