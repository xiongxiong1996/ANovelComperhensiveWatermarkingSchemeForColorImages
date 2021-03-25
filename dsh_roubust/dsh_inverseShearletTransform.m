function [inverse_stImg] = dsh_inverseShearletTransform(dst,shear_f,lpfilt)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ����������shearletTransform Tools��ʵ��shearlet��任��������任���ͼ�񻻳�uint8��ʽ���

% ���룺dst---dst(cell)������dst{1}Ϊshearlet�任�ĵ�Ƶ�Ӵ���dst{2}Ϊһ��L*L*H�����ݣ�����L*LΪԭͼ��С��HΪ�ֽ�ĸ�Ƶ�Ӵ�����
% ���룺shear_f---���������ڻָ�
% ���룺lpfilt---shearlet�任����
% �����inverse_stImg---shearlet��任����Ӵ���ͼ��

% ---------------------------------------------------------
inverse_stImg=nsst_rec2(dst,shear_f,lpfilt); % ��shearletת��
inverse_stImg=uint8(inverse_stImg); % ������ͼ��ת��Ϊuint8����
end

