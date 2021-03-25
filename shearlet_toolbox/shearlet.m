% shearlet_example
% This file gives an example of shearlet denoising.
% Code contributors: Glenn R. Easley, Demetrio Labate, and Wang-Q Lim

% Determine weather coefficients are to be displayed or not
% display_flag=0; % Do not display coefficients
display_flag=1; % Display coefficients

% ��ȡͼ��
% �������shearlet tools �ļ����У�����zonplate.png

% Load image
x=double(imread('barbara.gif'));
% I2938 = imread('2938.jpg');
% g2938 = rgb2gray(I2938);
% x=double(g2938);
% zonplate = imread('zonplate.png');
% x=double(zonplate);
[L L]=size(x);

% ��������ͼ��
% Create noisy image
sigma=20;
x_noisy=x+sigma.*randn(L,L);

% �趨 shearlet �任����
% setup parameters for shearlet transform
lpfilt='maxflat';
% .dcomp(i) ��ʾ���ｫ����2^dcomp(i)������
% .dcomp(i) indicates there will be 2^dcomp(i) directions 
shear_parameters.dcomp =[3 3 3 3 3 3];
% .dsize(i) ��ʾ�ֲ������˲�����СΪ disize(i)*disize(i)
% .dsize(i) indicate the local directional filter will be
% dsize(i) by dsize(i)
shear_parameters.dsize =[16 16 16 16 16 16];

% Tscalars����ѡ���׼ƫ���������Ƶ���ֵ�˷�����
% Tscalars(1)Ϊ��ͨϵ������ֵ����
% Tscalars(2)Ϊ��ͨϵ������ֵ����
% Tscalars(3)Ϊ��ͨϵ������ֵ������
% Tscalars determine the thresholding multipliers for
% standard deviation noise estimates. Tscalars(1) is the
% threshold scalar for the low-pass coefficients, Tscalars(2)
% is the threshold scalar for the band-pass coefficients, 
% Tscalars(3) is the threshold scalar for the high-pass
% coefficients. 

Tscalars=[0 3 4];

% �����ֿ��ܵķ�����ʵ�־ֲ����²�����shearletת��
% (nsst_dec1e,nsst_dec1, nsst_dec2)��
% �������ʾ�У����Ǵ�����һ����Ϊshear_version�ı�־
% ��ѡ��Ҫ������һ����
% There are three possible ways of implementing the 
% local nonsubsampled shearlet transform (nsst_dec1e,
% nsst_dec1, nsst_dec2). For this demo, we have created 
% a flag called shear_version to choose which one to
% test.

%shear_version=0; %nsst_dec1e
%shear_version=1; %nsst_dec1
shear_version=2; %nsst_dec2

% ������в��ֽ�
% compute the shearlet decompositon
if shear_version==0,
  [dst,shear_f]=nsst_dec1e(x_noisy,shear_parameters,lpfilt);
elseif shear_version==1, 
  [dst,shear_f]=nsst_dec1(x_noisy,shear_parameters,lpfilt);
elseif shear_version==2
  [dst,shear_f]=nsst_dec2(x,shear_parameters,lpfilt);
end

% ��һ����׼��Ϊ1�ĸ�˹������ͨ��ʱ��
% ʹ�����ؿ��޷���ȷ�����߶Ⱥͷ�������ĸ�˹�������ı�׼�
% Determines via Monte Carlo the standard deviation of
% the white Gaussian noise for each scale and 
% directional component when a white Gaussian noise of
% standard deviation of 1 is feed through.
if shear_version==0,
   dst_scalars=nsst_scalars_e(L,shear_f,lpfilt); 
   % L ͼ��ĳ���, shear_f�ֽ���Ķ�����lpfilt='maxflat';
else
   dst_scalars=nsst_scalars(L,shear_f,lpfilt);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%% ��ʾϵ�� %%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%% display coefficients %%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if display_flag==1,
   figure(1)
   imagesc(dst{1})
   for i=1:length(dst)-1,
       l=size(dst{i+1},3);
       JC=ceil(l/2);
       JR=ceil(l/JC);
       figure(i+1)
       for k=1:l,
           subplot(JR,JC,k)
           imagesc(abs(dst{i+1}(:,:,k)))
           axis off
           axis image
       end   
   end
end % display_flag 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ��shearletϵ��Ӧ��Ӳ��ֵ
% apply hard threshold to the shearlet coefficients
dst=nsst_HT(dst,sigma,Tscalars,dst_scalars);

% ���ݼ���ϵ���ؽ�ͼ��
% reconstruct the image from the shearlet coefficients
if shear_version==0,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==1,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==2,
    xr=nsst_rec2(dst,shear_f,lpfilt);      
end

% �������ܶ���
% compute measures of performance
p0 = MeanSquareError(x,x_noisy);
fprintf('Initial MSE = %f\n',p0);
p1 = MeanSquareError(x,xr);
fprintf('MSE After Denoising = %f\n',p1);
fprintf('Relative Error (norm) After Denoising = %f\n',norm(xr-x)/norm(x));
%RECONTRUCTION_ERROR = norm(xr-x)/norm(x)

figure(10)
imagesc(x)
title(['ORIGINAL IMAGE, size = ',num2str(L),' x ',num2str(L)])
colormap('gray')
axis off
axis image

figure(11)
imagesc(x_noisy)
title(['NOISY IMAGE, MSE = ',num2str(p0)])
colormap('gray')
axis off
axis image

figure(12)
imagesc(xr)
title(['RESTORED IMAGE, MSE = ',num2str(p1)])
colormap('gray')
axis off
axis image


