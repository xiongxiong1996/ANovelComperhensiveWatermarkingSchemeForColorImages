function [image_a,att_name] = attacks(Watermarked_Image,Attacks)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% This is a function for attacking the watermarked image
% 70种攻击、图片输入类型：uint8
% 本函数用于进行图片攻击测试，共包含了76种攻击大家可以根据需求选取。
% 输入：Watermarked_Image---嵌入水印后的图像
% 			Attacks---攻击类别 0-76的数字，不同数字会进行不同攻击
% 输出：image_a --- 攻击后的嵌入水印图像
% 			att_name --- 攻击名称
% ------------------------------------------------------------------
Watermarked_Image = im2uint8(Watermarked_Image);
[sizeX sizeY] = size(Watermarked_Image);
switch Attacks
    case 0
        image_a = Watermarked_Image;
        att_name = 'Non-Attack';
    case 1
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',90);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 90%)';
    case 2        
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',80);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 80%)';  
    case 3        
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',70);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 70%)'; 
    case 4       
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',60);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 60%)';
    case 5       
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',50);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 50%)'; 
    case 6      
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',40);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 40%)'; 
    case 7     
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',30);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 30%)'; 
    case 8      
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',20);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 20%)'; 
    case 9    
        imwrite(Watermarked_Image,'attackf.jpg','jpg','quality',10);
        image_a = imread('attackf.jpg');
        att_name = 'Lossy JPEG (QF = 10%)'; 
    case 10
        image_a = histeq(Watermarked_Image);
        att_name = 'Histogram equalization';
    case 11
        image_a = imadjust(Watermarked_Image,[],[0.5,1]);
        att_name = 'Image brighten';
%         figure(50);
%         imshow(image_a);title('brighten Image');
    case 12
        image_a = imadjust(Watermarked_Image,[],[0,0.85]);
        att_name = 'Image darken';  
%        figure(50);
%        imshow(image_a);title('darken Image');
    case 13        
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.001);
        att_name = 'Gaussian noise (σ= 0.1%)'; 
    case 14        
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.005);
        att_name = 'Gaussian noise (σ= 0.5%)'; 
    case 15
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.01);
        att_name = 'Gaussian noise (σ= 1%)';
    case 16
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.02);
        att_name = 'Gaussian noise (σ= 2%)'; 
    case 17
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.05);
        att_name = 'Gaussian noise (σ= 5%)'; 
    case 18
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.1);
        att_name = 'Gaussian noise (σ= 10%)'; 
    case 19
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.001);
        att_name = 'Salt-pepper noise (den = 0.1%)';
    case 20
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.005);
        att_name = 'Salt-pepper noise (den = 0.5%)';
    case 21
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.01);
        att_name = 'Salt-pepper noise (den = 1%)';
    case 22
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.02);
        att_name = 'Salt-pepper noise (den = 2%)';
    case 23
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.05);
        att_name = 'Salt-pepper noise (den = 5%)';
    case 24
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.1);
        att_name = 'Salt-pepper noise (den = 10%)';
    case 25
        image_a = imnoise(Watermarked_Image,'speckle',0.001);
        att_name = 'Speckle noise (0.1%)';
    case 26
        image_a = imnoise(Watermarked_Image,'speckle',0.01);
        att_name = 'Speckle noise (1%)';
    case 27
        image_a = imnoise(Watermarked_Image,'speckle',0.05);
        att_name = 'Speckle noise (5%)';
    case 28
        image_a = imnoise(Watermarked_Image,'speckle',0.1);
        att_name = 'Speckle noise (10%)';
    case 29
        h= fspecial('average', [3,3]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 3×3';
    case 30
        h= fspecial('average', [4,4]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 4×4';
    case 31
        h= fspecial('average', [5,5]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 5×5';
    case 32
        h= fspecial('average', [7,7]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 7×7';
    case 33
        h= fspecial('average', [9,9]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 9×9';
    case 34
        image_a=medfilt2(Watermarked_Image,[3,3]);
        att_name='Median filter 3×3';
    case 35
        image_a=medfilt2(Watermarked_Image,[4,4]);
        att_name='Median filter 4×4';
    case 36
        image_a=medfilt2(Watermarked_Image,[5,5]);
        att_name='Median filter 5×5';
    case 37
        image_a=medfilt2(Watermarked_Image,[7,7]);
        att_name='Median filter 7×7';
    case 38
        image_a=medfilt2(Watermarked_Image,[9,9]);
        att_name='Median filter 9×9';
    case 39
        h= fspecial('motion',3,3);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Motion filter 3×3';
    case 40
        h= fspecial('motion',4,4);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Motion filter 4×4';   
    case 41
        h= fspecial('motion',5,5);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Motion filter 5×5';  
    case 42
        h= fspecial('motion',7,7);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Motion filter 7×7'; 
    case 43
        h= fspecial('motion',9,9);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Motion filter 9×9'; 
    case 44
        h = fspecial('gaussian',3,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 3x3';
    case 45
        h = fspecial('gaussian',4,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 4x4';
    case 46
        h = fspecial('gaussian',5,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 5x5';
    case 47
        h = fspecial('gaussian',7,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 7x7';
    case 48
        Watermarked_Image(1:256,1:256)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 25% (Upper left)';
    case 49
        Watermarked_Image(1:256,256:512)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 25% (Upper right)'; 
    case 50
        Watermarked_Image(256:512,1:256)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 25% (bottom left)';
    case 51
        Watermarked_Image(256:512,256:512)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 25% (bottom right)';
    case 52
        Watermarked_Image(1:256,1:512)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 50% (Left half)';
    case 53
        Watermarked_Image(256:512,1:512)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 50% (right half)';
    case 54
        Watermarked_Image(1:512,1:256)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 50% (top half)';
    case 55
        Watermarked_Image(1:512,256:512)=randn();
        image_a=Watermarked_Image;
        att_name='Crop 50% (bottom half)';
    case 56
        image_a=imrotate(Watermarked_Image,0.5,'bilinear','crop');
        att_name='Rotation 0.5°'; 
    case 57
        image_a=imrotate(Watermarked_Image,2,'bilinear','crop');
        att_name='Rotation 2°';
    case 58
        image_a=imrotate(Watermarked_Image,5,'bilinear','crop');
        att_name='Rotation 5°';
    case 59
        image_a=imrotate(Watermarked_Image,25,'bilinear','crop');
        att_name='Rotation 25°';
    case 60
        image_a=imrotate(Watermarked_Image,45,'bilinear','crop');
        att_name='Rotation 45°';
    case 61
        image_a=imrotate(Watermarked_Image,70,'bilinear','crop');
        att_name='Rotation 70°';
    case 62
        image_a=imrotate(Watermarked_Image,125,'bilinear','crop');
        att_name='Rotation 125°';
    case 63
        image_a=imrotate(Watermarked_Image,-20,'bilinear','crop');
        att_name='Rotation -20°';
    case 64
        image_a=imrotate(Watermarked_Image,-100,'bilinear','crop');
        att_name='Rotation -100°';
    case 65
        image_a = imresize(Watermarked_Image,0.25);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 0.25';  
    case 66
        image_a = imresize(Watermarked_Image,0.5);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 0.5';
    case 67
        image_a = imresize(Watermarked_Image,0.8);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 0.8';
    case 68
        image_a = imresize(Watermarked_Image,0.9);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 0.9';
    case 69
        image_a = imresize(Watermarked_Image,1.1);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 1.1';  
    case 70
        image_a = imresize(Watermarked_Image,1.2);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 1.2';
    case 71
        image_a = imresize(Watermarked_Image,1.5);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 1.5';   
    case 72
        image_a = imresize(Watermarked_Image,2);
        image_a = imresize(image_a,[sizeX sizeY]);
        att_name='Scaling 2'; 
    case 73
        image_a = imtranslate(Watermarked_Image,[10,10]);
        att_name='Translation (10,10)'; 
    case 74
        image_a = imtranslate(Watermarked_Image,[10,20]);
        att_name='Translation (10,20)'; 
    case 75
        image_a = imtranslate(Watermarked_Image,[20,35]);
        att_name='Translation (20,35)'; 
    case 76
        image_a = imtranslate(Watermarked_Image,[50,50]);
        att_name='Translation (50,50)'; 
end