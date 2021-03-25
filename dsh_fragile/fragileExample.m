% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 用于脆弱水印的测试。使用hash序列和LSB嵌入的方法嵌入脆弱水印

% ---------------------------------------------------------

% 潜入完鲁棒水印的彩色图像读取
rwImg= imread('lena512color.tiff'); 

% 对宿主图像嵌入脆弱水印

[fwcImg] = dsh_embedFragileW(rwImg,16);


imwrite(fwcImg,'watermarkedImg.png'); % 将水印图像保存

% ----------------------------------------------------------------------

fwcImg = imread('watermarkedImg.png'); 


% 脆弱水印提取
[taggedImg] = dsh_extractFragileW(fwcImg,16);
