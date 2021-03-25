function [inverse_stImg] = dsh_inverseShearletTransform(dst,shear_f,lpfilt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 本函数借用shearletTransform Tools，实现shearlet逆变换，并将逆变换后的图像换成uint8格式输出

% 输入：dst---dst(cell)，其中dst{1}为shearlet变换的低频子带，dst{2}为一个L*L*H的数据，其中L*L为原图大小，H为分解的高频子带层数
% 输入：shear_f---参数，用于恢复
% 输入：lpfilt---shearlet变换参数
% 输出：inverse_stImg---shearlet逆变换后的子带或图像

% ---------------------------------------------------------
inverse_stImg=nsst_rec2(dst,shear_f,lpfilt); % 逆shearlet转换
inverse_stImg=uint8(inverse_stImg); % 将浮点图像转换为uint8类型
end

