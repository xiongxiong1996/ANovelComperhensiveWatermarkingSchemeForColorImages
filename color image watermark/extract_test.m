% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ���ڲ��Դ���ˮӡ��Ч������ΪһЩ������matlab�в����㣬���Խ�ˮӡͼ����󣬽��ж�ȡ���Դ���ˮӡ

% �ü�
fwcImg = imread('watermarkedImg2_1.png'); 

taggedImg1 = dsh_extractFragileW(fwcImg,16);
% ģ��
fwcImg = imread('watermarkedImg2_2.png'); 

taggedImg2 = dsh_extractFragileW(fwcImg,16);
% ��
fwcImg = imread('watermarkedImg2_3.png'); 

taggedImg3 = dsh_extractFragileW(fwcImg,16);
% ����
fwcImg = imread('watermarkedImg2_4.png'); 

taggedImg4 = dsh_extractFragileW(fwcImg,16);