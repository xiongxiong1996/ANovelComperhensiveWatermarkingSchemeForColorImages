% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ ddata ] = interpLocation( dog_imgs, height, width, octv, intvl, x, y, img_border, contr_thr, max_interp_steps )
% Function: Interpolates a scale-space extremum's location and scale
% 插值尺度空间极值的位置和尺度
% 通过三元二次函数拟合来精确确定关键点的位置和尺度，达到亚像素精度。
% 在任意一个维度大于0.5，说明极值点精确位置距离另一个点更近，
% 应该将关键点定位于更近的那个位置。定位到新点后再进行相同操作，
% 若迭代5次位置仍不收敛，则不认为此点为关键点。
global init_sigma;
global intvls;
i = 1;
while (i <= max_interp_steps)
    dD = deriv3D(intvl,x,y);
    H = hessian3D(intvl,x,y);
    [U,S,V] = svd(H);
    T=S;
    T(S~=0) = 1./S(S~=0);
    svd_inv_H = V * T' * U';
    x_hat = - svd_inv_H*dD; % 各个维度的偏移量
    if( abs(x_hat(1)) < 0.5 && abs(x_hat(2)) < 0.5 && abs(x_hat(3)) < 0.5)
        break; % 跳出while
    end
    x = x + round(x_hat(1));
    y = y + round(x_hat(2));
    intvl = intvl + round(x_hat(3));
    % 若超出范围，则ddata为空
    if (intvl < 2 || intvl > intvls+1 || x <= img_border || y <= img_border || x > height-img_border || y > width-img_border)
        ddata = [];
        return;
    end
    i = i+1;
end
% 如果迭代次数超过五次，则ddata为空
if (i > max_interp_steps)
    ddata = [];
    return;
end
contr = dog_imgs(x,y,intvl) + 0.5*dD'*x_hat;
% 判断阈值，如果阈值小于设定阈值，则ddata为空
% 经验值(Lowe论文中使用0.03，Rob Hess等人实现时使用0.04/S)
if ( abs(contr) < contr_thr/intvls )
    ddata = [];
    return;
end
% 如果上述不成立情况都避开，则进行ddata填写
ddata.x = x;
ddata.y = y;
ddata.octv = octv;
ddata.intvl = intvl;
ddata.x_hat = x_hat;
ddata.scl_octv = init_sigma * power(2,(intvl+x_hat(3)-1)/intvls);

function [ result ] = deriv3D(intvl, x, y)
    dx = (dog_imgs(x+1,y,intvl) - dog_imgs(x-1,y,intvl))/2;
    dy = (dog_imgs(x,y+1,intvl) - dog_imgs(x,y-1,intvl))/2;
    ds = (dog_imgs(x,y,intvl+1) - dog_imgs(x,y,intvl-1))/2;
    result = [dx,dy,ds]';
end

function [ result ] = hessian3D(intvl, x, y)
    center = dog_imgs(x,y,intvl);
    dxx = dog_imgs(x+1,y,intvl) + dog_imgs(x-1,y,intvl) - 2*center;
    dyy = dog_imgs(x,y+1,intvl) + dog_imgs(x,y-1,intvl) - 2*center;
    dss = dog_imgs(x,y,intvl+1) + dog_imgs(x,y,intvl-1) - 2*center;

    dxy = (dog_imgs(x+1,y+1,intvl)+dog_imgs(x-1,y-1,intvl)-dog_imgs(x+1,y-1,intvl)-dog_imgs(x-1,y+1,intvl))/4;
    dxs = (dog_imgs(x+1,y,intvl+1)+dog_imgs(x-1,y,intvl-1)-dog_imgs(x+1,y,intvl-1)-dog_imgs(x-1,y,intvl+1))/4;
    dys = (dog_imgs(x,y+1,intvl+1)+dog_imgs(x,y-1,intvl-1)-dog_imgs(x,y-1,intvl+1)-dog_imgs(x,y+1,intvl-1))/4;

    result = [dxx,dxy,dxs;dxy,dyy,dys;dxs,dys,dss];
end

end


