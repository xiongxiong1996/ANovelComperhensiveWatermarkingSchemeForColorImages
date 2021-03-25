function [dot_pair] = d_getDotPair(loc1, loc2,matched)
%D_GETDOTPAIR Summary of this function goes here
%   Detailed explanation goes here
% 生成点对
n=size(matched,2);
dot_pair=zeros(1,4);
dot_index=1;
for i=1:n
	if matched(i) ~= 0
		dot_pair(dot_index,1)=loc1(i,1);
		dot_pair(dot_index,2)=loc1(i,2);
		dot_pair(dot_index,3)=loc2(matched(i),1);
		dot_pair(dot_index,4)=loc2(matched(i),2);
		dot_index=dot_index+1;
	end
end
end

