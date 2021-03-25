% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [feat] = hist2Descr(feat,descr,descr_mag_thr)
% Function: Convert histogram to descriptor
% featΪ�������飬�洢features
% descrΪhist
% descr_mag_thr ����������Ԫ�ش�С����ֵ 0.2
% Ϊ�˼��ٹ��ձ仯��Ӱ�죬�Ը��������й�һ������
% �����Թ��ձ仯�Կ��ܵ����ݶȷ�ֵ�Ľϴ�仯��Ȼ��Ӱ���ݶȷ���Ŀ����Խ�С��
% ��˶��ڳ�����ֵ0.2���ݶȷ�ֵ��Ϊ0.2��Ȼ���ٽ���һ�ι�һ����
% ��������Ӱ��ն�Ӧ��˹������ͼ��ĳ߶ȴ�С����

descr = descr/norm(descr);
descr = min(descr_mag_thr,descr);
descr = descr/norm(descr);
feat.descr = descr;
end