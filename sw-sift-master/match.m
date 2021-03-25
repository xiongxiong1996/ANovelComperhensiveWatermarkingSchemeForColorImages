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
% distRatio���Կ�ֱ��������֮��ļнǽ���ƥ�䣬�൱��������롣ͼ��A ��������ƥ��ͼ��B��������������ӵ��֮��С��0.6������Ϊƥ��ɹ���
% for each descriptor in the first image, select its match to second image.
% des---n*128
des2t = des2';
n = size(des1,1); % n--feature�ĸ���
matched = zeros(1,n); % ����matchedΪ1*n
for i = 1 : n
   dotprods = des1(i,:) * des2t;
   [values,index] = sort(acos(dotprods)); % ���� arccos(dotprods)
   if (values(1) < distRatio * values(2))
      matched(i) = index(1);
   else
      matched(i) = 0;
   end
end

end