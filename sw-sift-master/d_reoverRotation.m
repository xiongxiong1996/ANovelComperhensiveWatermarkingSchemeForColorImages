function [recover_img,angle,avgAngle] = d_reoverRotation(des1,loc1,img)
% D_REOVERROTATION Summary of this function goes here
% ���ݵõ��ĽǶ���ת�ָ�ԭͼ��
%   Detailed explanation goes here
% ���룺 des1,loc1---����������ֵ+����������
% ���룺 img--- ��Ҫ��ת��ͼ��
% ����� recover_img --- ��ת�ָ���õ���ͼ��
[des2,loc2] = getFeatures(img,5);
matched = match(des1,des2,0.6);
dot_pair = d_getDotPair(loc1, loc2, matched);
[avgAngle,angle] = d_getAvgAngle(dot_pair);
% I1=imrotate(img,avgAngle); % ��ת��Ŵ�ͼ��

I2 = img;
if avgAngle < 0.2 && avgAngle < -0.2
else % if(isreal(avgAngle)==1)
	I2=imrotate(img,avgAngle,'crop'); % �õ�����ת��ͼ���ԭͼ��С��ͬ
end
% I3=imrotate(img,avgAngle,'bilinear','crop'); % ˫���Բ�ֵ����

recover_img = I2;
end

