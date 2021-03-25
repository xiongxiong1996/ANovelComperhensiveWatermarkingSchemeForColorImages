% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ matched ] = match( des1, des2,distRatio )
% Function: Match descriptors from the 1st to the 2nd, return matched index.
% matched vectors' angles from the nearest to second nearest neighbor is less than distRatio.
% distRatio所以可直接用向量之间的夹角进行匹配，相当于球面距离。图像A 的描述子匹配图像B最近的两个描述子点积之比小于0.6，则认为匹配成功。
% for each descriptor in the first image, select its match to second image.
% des---n*128
des2t = des2';
n = size(des1,1); % n--feature的个数
matched = zeros(1,n); % 定义matched为1*n
for i = 1 : n
   dotprods = des1(i,:) * des2t;
   [values,index] = sort(acos(dotprods)); % 排序 arccos(dotprods)
   if (values(1) < distRatio * values(2))
      matched(i) = index(1);
   else
      matched(i) = 0;
   end
end

end