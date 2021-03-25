% shearlet_example
% This file gives an example of shearlet denoising.
% Code contributors: Glenn R. Easley, Demetrio Labate, and Wang-Q Lim

% Determine weather coefficients are to be displayed or not
% display_flag=0; % Do not display coefficients
display_flag=1; % Display coefficients

% 读取图像
% 将其放入shearlet tools 文件夹中，测试zonplate.png

% Load image
x=double(imread('barbara.gif'));
% I2938 = imread('2938.jpg');
% g2938 = rgb2gray(I2938);
% x=double(g2938);
% zonplate = imread('zonplate.png');
% x=double(zonplate);
[L L]=size(x);

% 制造噪音图像
% Create noisy image
sigma=20;
x_noisy=x+sigma.*randn(L,L);

% 设定 shearlet 变换参数
% setup parameters for shearlet transform
lpfilt='maxflat';
% .dcomp(i) 表示这里将会有2^dcomp(i)个方向
% .dcomp(i) indicates there will be 2^dcomp(i) directions 
shear_parameters.dcomp =[3 3 3 3 3 3];
% .dsize(i) 表示局部定向滤波器大小为 disize(i)*disize(i)
% .dsize(i) indicate the local directional filter will be
% dsize(i) by dsize(i)
shear_parameters.dsize =[16 16 16 16 16 16];

% Tscalars用于选择标准偏差噪声估计的阈值乘法器。
% Tscalars(1)为低通系数的阈值标量
% Tscalars(2)为带通系数的阈值标量
% Tscalars(3)为高通系数的阈值标量。
% Tscalars determine the thresholding multipliers for
% standard deviation noise estimates. Tscalars(1) is the
% threshold scalar for the low-pass coefficients, Tscalars(2)
% is the threshold scalar for the band-pass coefficients, 
% Tscalars(3) is the threshold scalar for the high-pass
% coefficients. 

Tscalars=[0 3 4];

% 有三种可能的方法来实现局部非下采样的shearlet转换
% (nsst_dec1e,nsst_dec1, nsst_dec2)。
% 在这个演示中，我们创建了一个名为shear_version的标志
% 来选择要测试哪一个。
% There are three possible ways of implementing the 
% local nonsubsampled shearlet transform (nsst_dec1e,
% nsst_dec1, nsst_dec2). For this demo, we have created 
% a flag called shear_version to choose which one to
% test.

%shear_version=0; %nsst_dec1e
%shear_version=1; %nsst_dec1
shear_version=2; %nsst_dec2

% 计算剪切波分解
% compute the shearlet decompositon
if shear_version==0,
  [dst,shear_f]=nsst_dec1e(x_noisy,shear_parameters,lpfilt);
elseif shear_version==1, 
  [dst,shear_f]=nsst_dec1(x_noisy,shear_parameters,lpfilt);
elseif shear_version==2
  [dst,shear_f]=nsst_dec2(x,shear_parameters,lpfilt);
end

% 当一个标准差为1的高斯白噪声通过时，
% 使用蒙特卡罗方法确定各尺度和方向分量的高斯白噪声的标准差。
% Determines via Monte Carlo the standard deviation of
% the white Gaussian noise for each scale and 
% directional component when a white Gaussian noise of
% standard deviation of 1 is feed through.
if shear_version==0,
   dst_scalars=nsst_scalars_e(L,shear_f,lpfilt); 
   % L 图像的长宽, shear_f分解出的东西，lpfilt='maxflat';
else
   dst_scalars=nsst_scalars(L,shear_f,lpfilt);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%% 显示系数 %%%%%%%%%%%%%%%%%%%%%
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

% 对shearlet系数应用硬阈值
% apply hard threshold to the shearlet coefficients
dst=nsst_HT(dst,sigma,Tscalars,dst_scalars);

% 根据剪切系数重建图像
% reconstruct the image from the shearlet coefficients
if shear_version==0,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==1,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==2,
    xr=nsst_rec2(dst,shear_f,lpfilt);      
end

% 计算性能度量
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


