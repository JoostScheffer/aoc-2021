fid = fopen('input8.txt', 'rt');
% fid = fopen('test8_1.txt', 'rt');
% fid = fopen('test8.txt', 'rt');
data = textscan(fid, '%s %s %s %s %s %s %s %s %s %s | %s %s %s %s', 'HeaderLines', 0);
fclose(fid);

data = string([data{:}]).';
som_tot = 0;
for i=1:width(data)
    p = data(:,i);
    before = p(1:10, :);
    after = p(11:14, :);
    
    % part 1
    len = strlength(after);
    som = sum(sum(len == 2)) + sum(sum(len == 3)) + sum(sum(len == 4)) + sum(sum(len == 7));
%     disp(som);
    
    % part 2
    before = char(before);
    contained_letters = cell2mat(arrayfun(@(x) contained(before(x, :)), 1:height(before), 'UniformOutput', false).');
    Q = contained_letters;
    [mask_1, let_1] = decompose(Q, before, 2);
    [mask_4, let_4] = decompose(Q, before, 4);
    [mask_7, let_7] = decompose(Q, before, 3);
    [mask_8, let_8] = decompose(Q, before, 7);
    % all with 6 letters
    [a, b] = decompose(Q, before, 6);
    % 9 is the only one that has full overlap with 4
    tmp_9 = sum(and(a, mask_4), 2) == 4;
    mask_9 = a(tmp_9, :);
    let_9 = b(tmp_9, :);
    % 0
    ftr1 = sum(a&mask_7,2)==3;
    ftr2 = any( a~=mask_9,2);
    tmp_0 = ftr1&ftr2;
    
    % tmp = sum(and(a(any(a~=mask_9,2)), mask_7), 2) == 3;
    mask_0 = a(tmp_0, :);
    let_0 = b(tmp_0, :);
    % 6
    % tmp=any(xor(a,mask_9)&xor(a,mask_0),2);
    tmp = ~(tmp_0|tmp_9);
    mask_6 = a(tmp,:);
    let_6 = b(tmp,:);
    
    % all with 5 letters
    [a, b] = decompose(Q, before, 5);
    % 3 is the only one that has full overlap with 7
    tmp_3 = sum(and(a, mask_7), 2) == 3;
    mask_3 = a(tmp_3,:);
    let_3 = b(tmp_3,:);
    % 5 is the only one that has 5 overlapping with 6
    tmp_5 = sum(a&mask_6,2)==5;
    mask_5 = a(tmp_5,:);
    let_5 = b(tmp_5,:);
    % 2 also has 5 letters and is not 3 nor 5
    tmp = ~(tmp_3|tmp_5);
    mask_2 = a(tmp,:);
    let_2 = b(tmp,:);
    
    keys = {let_0; let_1; let_2; let_3; let_4; let_5; let_6; let_7; let_8; let_9};
    values = [0 1 2 3 4 5 6 7 8 9];
    M = containers.Map(keys, values);
    
    after = sort(char(after),2);
    som = 0;
    for j=1:4
        val = after(j,:);
        som = som*10 + M(strip(val));
    end
    som_tot = som_tot + som;
    disp(som);
end

function [mask, letters] = decompose(Q, before, length)
tmp = sum(Q, 2) == length;
mask = Q(tmp, :);
%     letters = sort(strip(before(tmp, :)));
letters = cell2mat(arrayfun(@(x) sort(char(strip(x))), string(before(tmp, :)), 'UniformOutput', false));
end

function mask = contained(letters)
order = ["a", "b", "c", "d", "e", "f", "g"];
N = numel(letters);
masks = arrayfun(@(x) order == letters(x), 1:N, 'UniformOutput', false);
mask = any(cell2mat(masks.'));
end