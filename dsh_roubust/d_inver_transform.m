function [watermarked_Img] = d_inver_transform(ll_prim,wname,dst,shear_f,lpfilt,ch,cv,cd)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ���������ڻָ��ָ�ͼ��ʵ����任����shearlet��DWT

% ���룺ll_prim,s1,wname,dst,shearf,lpfilt,ch,cv,cd ---�������ڻָ��Ĳ���
% �����w_Img---��任��õ��ĺ���ˮӡ��ͼ��

% ---------------------------------------------------------

dst1=idwt2(ll_prim,ch,cv,cd,wname);
dst{1}=dst1;
watermarked_Img = dsh_inverseShearletTransform(dst,shear_f,lpfilt);
end

