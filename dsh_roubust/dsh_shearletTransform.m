% function [max_entropy_subband,max_n,dst,shear_f,lpfilt] = dsh_shearletTransform(layer,s1,display_flag)
% 函数dsh_shearletTransfrom
% 输出：max_entropy_subband---熵值最大的子带
% 输出：max_n---最大熵子带编号
function [dst,shear_f,lpfilt] = dsh_shearletTransform(layer,s1,display_flag)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 本函数调用shearletTransform Tools，实现shearlet变换

% 输入：layer---将要变换的层，或者灰度图像
% 输入：s1---shearlet变换的方向
% 输入：display_flag---显示表示，输入1将会把shearlet变换的中间过程全部显示
% 输出：shear_f---参数，用于恢复
% 输出：lpfilt---shearlet变换参数
% 输出：dst---dst(cell)，其中dst{1}为shearlet变换的低频子带，dst{2}为一个L*L*H的数据，其中L*L为原图大小，H为分解的高频子带层数

% ---------------------------------------------------------

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%    剪切波变换    %%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 对输入的层变换成double类型，并获取其大小。
x=double(layer);
[L L]=size(x);

% 设定 shearlet 变换参数
lpfilt='maxflat';

% .dcomp(i) 表示这里将会有2^dcomp(i)个方向,此处可以控制进行shearlet变换的次数！[s2 s2] 则会进行两次变换
shear_parameters.dcomp =[s1];

% .dsize(i) 表示局部定向滤波器大小为 disize(i)*disize(i)
shear_parameters.dsize =[16 16];


% 有三种可能的方法来实现局部非下采样的shearlet转换
% (nsst_dec1e,nsst_dec1, nsst_dec2)。
% 创建了一个名为shear_version的标志来选择要使用哪一个。


% shear_version=0; %nsst_dec1e
% shear_version=1; %nsst_dec1
shear_version=2; % nsst_dec2

% 计算剪切波分解
% compute the shearlet decompositon
if shear_version==0,
  [dst,shear_f]=nsst_dec1e(x,shear_parameters,lpfilt);
elseif shear_version==1, 
  [dst,shear_f]=nsst_dec1(x,shear_parameters,lpfilt);
elseif shear_version==2
  [dst,shear_f]=nsst_dec2(x,shear_parameters,lpfilt);
end % shear_version

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%   找出最大熵子带   %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 找出shearlet transform后熵最大的sub-band
% max_n=1; % 最大熵值的子带编号
% max_entropy=0; % 最大熵
% % size(obj,dim), dim选择显示的维度，此处函数意思为计算dst{2}的第三维的size，该案例中dst{2}是一个512*512*8的数据
% l=size(dst{2},3); 
% for k=1:l,
%   sb_entropy = entropy(abs(dst{2}(:,:,k))); % 计算熵
%   if sb_entropy > max_entropy % 若当前子带的熵比现有的最大熵大
%  		max_entropy = sb_entropy;
% 		max_n = k;
% 	end % if
% end % for

% 显示熵最大的子带
% figure(9);
% imagesc(abs(dst{2}(:,:,k)));

% 定义最大熵子带
% max_entropy_subband=(dst{2}(:,:,max_n));


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%% 显示shearlet transform %%%%%%%%%%%
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
           entropyo = entropy(abs(dst{i+1}(:,:,k))); % 计算熵
           title(['entropy=',num2str(entropyo)]); % 显示熵
           axis off
           axis image
       end % for  
   end % for
end % display_flag



end % function


