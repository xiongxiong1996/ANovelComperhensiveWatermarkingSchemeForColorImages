function [rgb_sharped] = sharpening(Img)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% Èñ»¯
rgb=im2double(Img);
lapMatrix=[-1 -1 -1;-1 8 -1;-1 -1 -1];
rgb_R=rgb(:,:,1);
rgb_G= rgb(:,:,2);
rgb_B= rgb(:,:,3);
f_R=imfilter(rgb_R,lapMatrix,'replicate');
f_G=imfilter(rgb_G,lapMatrix,'replicate');
f_B=imfilter(rgb_B,lapMatrix,'replicate');
rgb_tmp=cat(3,f_R,f_G,f_B);
rgb_sharped =imsubtract(rgb,rgb_tmp);
rgb_sharped=im2uint8(rgb_sharped);
end

