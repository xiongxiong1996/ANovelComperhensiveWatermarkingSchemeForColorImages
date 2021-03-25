% 
%   Copyright (C) 2020 Liu yunpeng <yunpeng2000china@gmail.com>
% 
%   本方法用于对图像进行四叉树分解，并在每一个块中，仅选取一个特征点。

function [fdes,floc] = L_getFliterFeature(img,des,loc,n)
% 输入为图片和其对应的特征值
% 输出为图片筛选后的特征值
img_gray= rgb2gray(img);% 转为灰度图像
S = qtdecomp(img_gray,.27,8);% 分块处理
S=full(S);            % 转为全矩阵
[Sr,Sc] = size(S);    % 获取S矩阵长宽
[Lr,Lc] = size(loc);  % 获取loc矩阵长宽
ftdes=zeros(size(des));% 定义筛选后的des矩阵
ftloc=zeros(size(loc));% 定义筛选后的loc矩阵
index=0;              % 初始化新特征点数
 for i = 1:Sr        % 建立for循环嵌套
    for j = 1:Sc
        if S(i,j) ~= 0  % 读取矩阵每个位置数据，先行后列
           count=0;  %初始化每块点数统计，
           for k=1:Lr
               if loc(k,2)>=i && loc(k,2)<S(i,j)+i && loc(k,1)>=j && loc(k,1)<S(i,j)+j% 这个点坐标要在(i,i+S（i,j),j,j+S（i,j))之间
                   index=index+1;        % 新特征点数加1 
                   count=count+1;       % 点数加1
                   ftdes(index,:)=des(k,:); % 存入临时des
                   ftloc(index,:)=loc(k,:); % 存入临时loc
                   if(count>n-1)% 点数为1 跳出循环
                       break
                   end
               end
           end
        end
    end
 end
fdes=zeros(index,128);% 定义筛选后的des矩阵
floc=zeros(index,2);% 定义筛选后的loc矩阵
fdes=ftdes(1:index,:);
floc=ftloc(1:index,:);
