function [hash_right,error_num] = dsh_compareHash(hash_sequence,hw_array)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% �˷������ڱȽ�����hash�����Ƿ���ͬ���������Ż���������

% ���룺hash_sequence��hw_array---��Ҫ�Ƚϵ�����hash����
% �����hash_right---hash��־��1Ϊƥ��ɹ�0Ϊʧ��
% �����error_num---hash���в�ƥ�������û�ã�

% ---------------------------------------------------------
l = length(hash_sequence);
error_num=0;
hash_right=1;
for i=1:l
	if hw_array(i)==2
	else if hash_sequence(i) == hw_array(i);
	else
		hash_right=0;
		error_num=error_num+1;
	end
end
end

