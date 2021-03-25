

I1 = imread('watermarkedImg.png'); % 水印后的图
I2 = imread('TImg.png'); % 篡改后的图
[L L n] = size(I1);
tmap1 = zeros(L,L);

for i=1:L
	for j=1:L
		if (I1(i,j,1)==I2(i,j,1)&&I1(i,j,2)==I2(i,j,2)&&I1(i,j,3)==I2(i,j,3))
		else
			tmap1(i,j)=1;
		end
	end
end

[taggedImg,tmap2] = dsh_extractFragileMap(I2,16) % 篡改检测后的图

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
% 准确度
acc = (tn_num + tp_num) / (fp_num + fn_num + tp_num + tn_num);