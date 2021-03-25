function [recover_img,angle,avgAngle] = d_reoverRotation(des1,loc1,img)
% D_REOVERROTATION Summary of this function goes here
% 根据得到的角度旋转恢复原图像
%   Detailed explanation goes here
% 输入： des1,loc1---特征点特征值+特征点坐标
% 输入： img--- 需要旋转的图像
% 输出： recover_img --- 旋转恢复后得到的图像
[des2,loc2] = getFeatures(img,5);
matched = match(des1,des2,0.6);
dot_pair = d_getDotPair(loc1, loc2, matched);
[avgAngle,angle] = d_getAvgAngle(dot_pair);
% I1=imrotate(img,avgAngle); % 旋转后放大图像

I2 = img;
if avgAngle < 0.2 && avgAngle < -0.2
else % if(isreal(avgAngle)==1)
	I2=imrotate(img,avgAngle,'crop'); % 得到的旋转后图像和原图大小相同
end
% I3=imrotate(img,avgAngle,'bilinear','crop'); % 双线性插值补充

recover_img = I2;
end

