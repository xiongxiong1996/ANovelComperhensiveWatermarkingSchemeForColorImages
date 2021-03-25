function [I,attack_name] = fragile_attacks(watermarkedImg,x1,y1,x2,y2,attack_type)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% ���������ڶ�ͼ����д۸Ĺ��� ģ�������Ρ���˹���˲������񻯡��ü�

I = watermarkedImg;
crop_Img = imcrop(I,[x1,y1,abs(x1-x2),abs(y1-y2)]);
% crop_Img = imnoise(crop_Img,'salt & pepper',0.001);
switch attack_type
	case 1
		% %%% ģ��
		PSF = fspecial('motion',5,3); % 20  15
		crop_Img = imfilter(crop_Img,PSF,'conv','circular');
		attack_name='motion';
	case 2
		% %%% ��������
		crop_Img = imnoise(crop_Img,'salt & pepper',0.1);
		attack_name='salt & pepper noise';
	case 3
		% %%% ��˹����
		crop_Img = imnoise(crop_Img,'gaussian',0,0.01);
		attack_name='gaussian noise';
	case 4
		% %%% �˲���
		h= fspecial('average', [5,5]);
		crop_Img=imfilter(crop_Img,h);
		attack_name='average filter';
	case 5
		% %%% ��
		crop_Img = sharpening(crop_Img);
		attack_name='sharpening';
	case 6
		% %%% �ü�
		crop_Img = 0;
		attack_name='crop';
end
I(y1:y2,x1:x2,:)=crop_Img; % ���޸��������
end

