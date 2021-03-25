% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 用于测试脆弱水印的效果，因为一些操作再matlab中不方便，所以将水印图像处理后，进行读取测试脆弱水印

% 裁剪
fwcImg = imread('watermarkedImg2_1.png'); 

taggedImg1 = dsh_extractFragileW(fwcImg,16);
% 模糊
fwcImg = imread('watermarkedImg2_2.png'); 

taggedImg2 = dsh_extractFragileW(fwcImg,16);
% 锐化
fwcImg = imread('watermarkedImg2_3.png'); 

taggedImg3 = dsh_extractFragileW(fwcImg,16);
% 噪声
fwcImg = imread('watermarkedImg2_4.png'); 

taggedImg4 = dsh_extractFragileW(fwcImg,16);