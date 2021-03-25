function [ll,dst,shear_f,lpfilt,ch,cv,cd] = d_get_ll(host_image,s1,wname)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 本函数对宿主图像/含水印图像进行shearlet变换后取出低频区域再进行进行1level-DWT2取低频区域

% 输入：hotst_image---宿主图像/含水印图像
% 输入：s1---shearlet变换级数
% 输入：wname---小波变换小波名
% 输出：ll---获取到的低频区域
% 输出：dst---shearlet变换后所有的子带
% 输出：shear_f---shearlet 变换参数，用于逆变换
% 输出：ch,cv,cd---DWT2变换参数，用于逆变换

% ---------------------------------------------------------

[dst,shear_f,lpfilt] = dsh_shearletTransform(host_image,s1,0);

dst1=dst{1};

% ca = LL 
[ca ch cv cd] = dwt2(dst1,wname);


ll=ca;


end

