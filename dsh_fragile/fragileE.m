

I1 = imread('watermarkedImg.png'); % ˮӡ���ͼ
I2 = imread('TImg.png'); % �۸ĺ��ͼ
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

[taggedImg,tmap2] = dsh_extractFragileMap(I2,16) % �۸ļ����ͼ

tp_num=0; % ����
tn_num=0; % ����
fp_num=0; % ����
fn_num=0; % ����

for i=1:L
	for j=1:L
		if (tmap1(i,j)==1&&tmap2(i,j)==1) % ����
			tp_num=tp_num+1;
		end
		if (tmap1(i,j)==0&&tmap2(i,j)==0) % ����
			tn_num=tn_num+1;
		end
		if (tmap1(i,j)==0&&tmap2(i,j)==1) % ����
			fp_num=fp_num+1;
		end
		if (tmap1(i,j)==1&&tmap2(i,j)==0) % ����
			fn_num=fn_num+1;
		end
	end
end


% ��������
fpr = fp_num / (fp_num + tn_num);
% ��������
fnr = fn_num / (fn_num + tp_num);
% ��������
tpr = tp_num / (tp_num + fn_num);
% ׼ȷ��
acc = (tn_num + tp_num) / (fp_num + fn_num + tp_num + tn_num);