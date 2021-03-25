% function [max_entropy_subband,max_n,dst,shear_f,lpfilt] = dsh_shearletTransform(layer,s1,display_flag)
% ����dsh_shearletTransfrom
% �����max_entropy_subband---��ֵ�����Ӵ�
% �����max_n---������Ӵ����
function [dst,shear_f,lpfilt] = dsh_shearletTransform(layer,s1,display_flag)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% ����������shearletTransform Tools��ʵ��shearlet�任

% ���룺layer---��Ҫ�任�Ĳ㣬���߻Ҷ�ͼ��
% ���룺s1---shearlet�任�ķ���
% ���룺display_flag---��ʾ��ʾ������1�����shearlet�任���м����ȫ����ʾ
% �����shear_f---���������ڻָ�
% �����lpfilt---shearlet�任����
% �����dst---dst(cell)������dst{1}Ϊshearlet�任�ĵ�Ƶ�Ӵ���dst{2}Ϊһ��L*L*H�����ݣ�����L*LΪԭͼ��С��HΪ�ֽ�ĸ�Ƶ�Ӵ�����

% ---------------------------------------------------------

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%    ���в��任    %%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ������Ĳ�任��double���ͣ�����ȡ���С��
x=double(layer);
[L L]=size(x);

% �趨 shearlet �任����
lpfilt='maxflat';

% .dcomp(i) ��ʾ���ｫ����2^dcomp(i)������,�˴����Կ��ƽ���shearlet�任�Ĵ�����[s2 s2] ���������α任
shear_parameters.dcomp =[s1];

% .dsize(i) ��ʾ�ֲ������˲�����СΪ disize(i)*disize(i)
shear_parameters.dsize =[16 16];


% �����ֿ��ܵķ�����ʵ�־ֲ����²�����shearletת��
% (nsst_dec1e,nsst_dec1, nsst_dec2)��
% ������һ����Ϊshear_version�ı�־��ѡ��Ҫʹ����һ����


% shear_version=0; %nsst_dec1e
% shear_version=1; %nsst_dec1
shear_version=2; % nsst_dec2

% ������в��ֽ�
% compute the shearlet decompositon
if shear_version==0,
  [dst,shear_f]=nsst_dec1e(x,shear_parameters,lpfilt);
elseif shear_version==1, 
  [dst,shear_f]=nsst_dec1(x,shear_parameters,lpfilt);
elseif shear_version==2
  [dst,shear_f]=nsst_dec2(x,shear_parameters,lpfilt);
end % shear_version

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%   �ҳ�������Ӵ�   %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �ҳ�shearlet transform��������sub-band
% max_n=1; % �����ֵ���Ӵ����
% max_entropy=0; % �����
% % size(obj,dim), dimѡ����ʾ��ά�ȣ��˴�������˼Ϊ����dst{2}�ĵ���ά��size���ð�����dst{2}��һ��512*512*8������
% l=size(dst{2},3); 
% for k=1:l,
%   sb_entropy = entropy(abs(dst{2}(:,:,k))); % ������
%   if sb_entropy > max_entropy % ����ǰ�Ӵ����ر����е�����ش�
%  		max_entropy = sb_entropy;
% 		max_n = k;
% 	end % if
% end % for

% ��ʾ�������Ӵ�
% figure(9);
% imagesc(abs(dst{2}(:,:,k)));

% ����������Ӵ�
% max_entropy_subband=(dst{2}(:,:,max_n));


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%% ��ʾshearlet transform %%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if display_flag==1,
   figure(1)
   imagesc(dst{1})
   for i=1:length(dst)-1,
       l=size(dst{i+1},3);
       JC=ceil(l/2);
       JR=ceil(l/JC);
       figure(i+1)
       for k=1:l,
           subplot(JR,JC,k)
           imagesc(abs(dst{i+1}(:,:,k)))
           entropyo = entropy(abs(dst{i+1}(:,:,k))); % ������
           title(['entropy=',num2str(entropyo)]); % ��ʾ��
           axis off
           axis image
       end % for  
   end % for
end % display_flag



end % function


