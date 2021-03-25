function [ll,dst,shear_f,lpfilt,ch,cv,cd] = d_get_ll(host_image,s1,wname)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ������������ͼ��/��ˮӡͼ�����shearlet�任��ȡ����Ƶ�����ٽ��н���1level-DWT2ȡ��Ƶ����

% ���룺hotst_image---����ͼ��/��ˮӡͼ��
% ���룺s1---shearlet�任����
% ���룺wname---С���任С����
% �����ll---��ȡ���ĵ�Ƶ����
% �����dst---shearlet�任�����е��Ӵ�
% �����shear_f---shearlet �任������������任
% �����ch,cv,cd---DWT2�任������������任

% ---------------------------------------------------------

[dst,shear_f,lpfilt] = dsh_shearletTransform(host_image,s1,0);

dst1=dst{1};

% ca = LL 
[ca ch cv cd] = dwt2(dst1,wname);


ll=ca;


end

