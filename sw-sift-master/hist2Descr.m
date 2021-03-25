% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [feat] = hist2Descr(feat,descr,descr_mag_thr)
% Function: Convert histogram to descriptor
% feat为特征数组，存储features
% descr为hist
% descr_mag_thr 描述向量的元素大小的阈值 0.2
% 为了减少光照变化的影响，对该向量进行归一化处理。
% 非线性光照变化仍可能导致梯度幅值的较大变化，然而影响梯度方向的可能性较小。
% 因此对于超过阈值0.2的梯度幅值设为0.2，然后再进行一次归一化。
% 最后将描述子按照对应高斯金字塔图像的尺度大小排序。

descr = descr/norm(descr);
descr = min(descr_mag_thr,descr);
descr = descr/norm(descr);
feat.descr = descr;
end