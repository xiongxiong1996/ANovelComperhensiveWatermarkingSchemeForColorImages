function random_sequence = get_hash_sequence(K,meth)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
%   Note: 
% 得到hash序列

% 输入：K---密钥
% 输入：meth---生成方法
% 输出：random_sequence---生成的随机序列

% ---------------------------------------------------------
    clc;
    hash_str = hash(K,meth);
    hash_str_len = length(hash_str);
    random_sequence = zeros([1,hash_str_len^2]);
    random_sequence_index = 1;
    count_1 = 1;
    for i=1:hash_str_len
        hash_temp_str = hash(hash_str(i:i),meth);
        hash_temp_str = isletter(hash_temp_str);
        for j=1:hash_str_len
            random_sequence(random_sequence_index) = hash_temp_str(j);
            if hash_temp_str(j) == 1
                count_1 = count_1 + 1;
            end
            random_sequence_index = random_sequence_index + 1;
        end
    end
    
    % 查看我们生成的二进制码流有多少个1
    % disp(count_1);
    
    % 查看我们生成的二进制码流组成图片是什么样的.
    % img_hash = zeros([hash_str_len,hash_str_len]);
    % for i =1:hash_str_len
    %     for j =1:hash_str_len
    %         img_hash(i,j) = random_sequence((i-1)*hash_str_len + j);
    %     end
    % end
    % figure;
    % imshow(img_hash);    
end
