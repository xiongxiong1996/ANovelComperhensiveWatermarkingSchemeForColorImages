
% %%%%%%%%%%%%%%%%%%%%%%%%   脆弱测试1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I = imread('watermarkedImg.png');
% 
% for i=1:6
% 	I = imread('watermarkedImg.png');
% 	eval(['I',num2str(i),'=','fragile_att(I,i)',';'])
% end 


% 
% T1 = dsh_extractFragileW(I1,16);
% T2 = dsh_extractFragileW(I2,16);
% T3 = dsh_extractFragileW(I3,16);
% T4 = dsh_extractFragileW(I4,16);
% T5 = dsh_extractFragileW(I5,16);
% T6 = dsh_extractFragileW(I6,16);
% 
% 
% subplot(2,6,1),imshow(I1),title('a1');subplot(2,6,2),imshow(I2),title('a2');subplot(2,6,3),imshow(I3),title('a3');
% subplot(2,6,4),imshow(I4),title('a4');subplot(2,6,5),imshow(I5),title('a5');subplot(2,6,6),imshow(I6),title('a6');
% 
% subplot(2,6,7),imshow(T1),title('t1');subplot(2,6,8),imshow(T2),title('t2');subplot(2,6,9),imshow(T3),title('t3');
% subplot(2,6,10),imshow(T4),title('t4');subplot(2,6,11),imshow(T5),title('t5');subplot(2,6,12),imshow(T6),title('t6');

% %%%%%%%%%%%%%%%%%%%%%%%   脆弱测试2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% I1=imread('TImg1.png');
% I2=imread('TImg2.png');
% I3=imread('TImg3.png');
% I4=imread('TImg4.png');
% I5=imread('TImg5.png');
% I6=imread('TImg6.png');
% 
% 
% 
% T1 = dsh_extractFragileW(I1,16);
% T2 = dsh_extractFragileW(I2,16);
% T3 = dsh_extractFragileW(I3,16);
% T4 = dsh_extractFragileW(I4,16);
% T5 = dsh_extractFragileW(I5,16);
% T6 = dsh_extractFragileW(I6,16);
% 
% 
% imwrite(T1,'T1.png');
% imwrite(T2,'T2.png');
% imwrite(T3,'T3.png');
% imwrite(T4,'T4.png');
% imwrite(T5,'T5.png');
% imwrite(T6,'T6.png');
% 
% 
% 
% subplot(2,6,1),imshow(I1),title('a1');subplot(2,6,2),imshow(I2),title('a2');subplot(2,6,3),imshow(I3),title('a3');
% subplot(2,6,4),imshow(I4),title('a4');subplot(2,6,5),imshow(I5),title('a5');subplot(2,6,6),imshow(I6),title('a6');
% 
% subplot(2,6,7),imshow(T1),title('t1');subplot(2,6,8),imshow(T2),title('t2');subplot(2,6,9),imshow(T3),title('t3');
% subplot(2,6,10),imshow(T4),title('t4');subplot(2,6,11),imshow(T5),title('t5');subplot(2,6,12),imshow(T6),title('t6');

% %%%%%%%%%%%%%%%%%%%%%%%   脆弱测试2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





value=zeros(6,5); % 用于存放攻击后图像的鲁棒性信息
for i=1:6
	I = imread('watermarkedImg.png');
	J=fragile_att(I,i);
	[fpr,fnr,tpr,tnr,acc] = dsh_FragileExample(I,J);
	value(i,1)=fpr;
	value(i,2)=fnr;
	value(i,3)=tpr;
	value(i,4)=tnr;
	value(i,5)=acc;
end 




% value=zeros(6,5); % 用于存放攻击后图像的鲁棒性信息
% for num=1:6
% 	imgname = ['Img', sprintf('%01d', num), '.png'];
% 	I=imread(imgname);
% 	imgname = ['TImg', sprintf('%01d', num), '.png'];
% 	J=imread(imgname);
% 	[fpr,fnr,tpr,tnr,acc] = dsh_FragileExample(I,J);
% 	value(num,1)=fpr;
% 	value(num,2)=fnr;
% 	value(num,3)=tpr;
% 	value(num,4)=tnr;
% 	value(num,5)=acc;
% end 