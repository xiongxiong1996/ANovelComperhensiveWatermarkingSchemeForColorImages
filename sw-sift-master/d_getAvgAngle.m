function [avgAngle,angle] = d_getAvgAngle(dot_pair)
% D_GETAVGANGLE Summary of this function goes here
%   Detailed explanation goes here
% dot_pair=unique(dot_pair,'row'); % 去除dot_pair 中的重复行 !!!其实没啥用了已经
n=size(dot_pair,1);
angle=zeros(1,n*(n-1)/2);
n_angle=zeros(1,1);
a=0;
angel_index=0;
for i=1:n
	for j=i+1:n
		angel_index=angel_index+1;
		angle(angel_index)=getAngle([dot_pair(i,1),dot_pair(i,2)],[dot_pair(j,1),dot_pair(j,2)],[dot_pair(i,3),dot_pair(i,4)],[dot_pair(j,3),dot_pair(j,4)]);
	end
end


angle=d_cleanData(angle); % 清洗数据

count = size(angle,2); % 清洗后剩余数据个数

for i=1:count
	if ~isnan(angle(i)) % 去除NaN数据
		a=a+angle(i);
	end
end
avgAngle = a/count;
avgAngle=roundn(avgAngle,-4) 
end

