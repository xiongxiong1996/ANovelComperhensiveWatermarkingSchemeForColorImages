function [fpr,fnr,tpr,tnr,acc] = dsh_FragileExample(watermarkedImg,TImg)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 实现计算fpr fnr tpr tnr acc
% 输入：watermarkedImg---嵌入完水印的图像
% 输入：TImg---遭到篡改后的图像
% 输出：fpr,fnr,tpr,tnr,acc---假阳率，假阴率，真阳率，真阴率，准确率

I1 = watermarkedImg; % 水印后的图
I2 = TImg; % 篡改后的图

[L L n] = size(I1); % 水印图的大小
tmap1 = zeros(L,L); % 生成同大小的篡改图，tmap1 用于存放原图和篡改后图的篡改位置

for i=1:L
	for j=1:L
		if (I1(i,j,1)==I2(i,j,1)&&I1(i,j,2)==I2(i,j,2)&&I1(i,j,3)==I2(i,j,3)) % 因为是彩色图像，三层中，有一层不同，即可视为修改
		else
			tmap1(i,j)=1; % 修改标记
		end
	end
end

[taggedImg,tmap2] = dsh_extractFragileMap(I2,16); % 篡改检测后的图(现有方法extractFragile改编)

tp_num=0; % 真阳
tn_num=0; % 真阴
fp_num=0; % 假阳
fn_num=0; % 假阴

for i=1:L
	for j=1:L
		if (tmap1(i,j)==1&&tmap2(i,j)==1) % 真阳
			tp_num=tp_num+1;
		end
		if (tmap1(i,j)==0&&tmap2(i,j)==0) % 真阴
			tn_num=tn_num+1;
		end
		if (tmap1(i,j)==0&&tmap2(i,j)==1) % 假阳
			fp_num=fp_num+1;
		end
		if (tmap1(i,j)==1&&tmap2(i,j)==0) % 假阴
			fn_num=fn_num+1;
		end
	end
end


% 假阳性率
fpr = fp_num / (fp_num + tn_num);
% 假阴性率
fnr = fn_num / (fn_num + tp_num);
% 真阳性率
tpr = tp_num / (tp_num + fn_num);
% 真阴性率
tnr = tn_num / (tn_num + fn_num);
% 准确度
acc = (tn_num + tp_num) / (fp_num + fn_num + tp_num + tn_num);
end

