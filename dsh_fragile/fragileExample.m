% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ���ڴ���ˮӡ�Ĳ��ԡ�ʹ��hash���к�LSBǶ��ķ���Ƕ�����ˮӡ

% ---------------------------------------------------------

% Ǳ����³��ˮӡ�Ĳ�ɫͼ���ȡ
rwImg= imread('lena512color.tiff'); 

% ������ͼ��Ƕ�����ˮӡ

[fwcImg] = dsh_embedFragileW(rwImg,16);


imwrite(fwcImg,'watermarkedImg.png'); % ��ˮӡͼ�񱣴�

% ----------------------------------------------------------------------

fwcImg = imread('watermarkedImg.png'); 


% ����ˮӡ��ȡ
[taggedImg] = dsh_extractFragileW(fwcImg,16);
