function [c_angle] = d_cleanData(angle)
% D_CLEANDATA Summary of this function goes here
%   Detailed explanation goes here
% Q1 四分位数 Q3 3/4位数 IQR 中位数
angle_index = size(angle,2);
c_angle=zeros(1,1);
Q1 = prctile(angle,25);
Q3 = prctile(angle,75);
IQR = Q3-Q1;
outlier_step = 1.5 * IQR;
outline_cell = Q3 + outlier_step;
outline_floor = Q1 - outlier_step;
figure(10);
boxplot(angle);
n=1;
for i=1:angle_index
	if angle(i) <= outline_cell && angle(i) >= outline_floor
		c_angle(n) = angle(i);
		n=n+1;
	end
end
end

