fid = fopen('input3.txt', 'rt');
data = textscan(fid, '%c');
fclose(fid);
clear fid

array = reshape((data{:}), [12, 1000]).';

% part 1
h = 1000;
gamma = arrayfun(@(x) sum(array(:, x) == '1') > h/2, 1:12);
epsilon = bin2dec(sprintf("%d", ~gamma));
gamma = bin2dec(sprintf("%d", gamma));
display(gamma*epsilon);

% part 2
if sum(array(:, 1) == '1') >= height(array) / 2
    most_common = '1';
else
    most_common = '0';
end
oxygen = array((array(:, 1) == most_common), :);
co2 = array((array(:, 1) ~= most_common), :);
for i = 2:width(array)
    if sum(co2(:, i) == '1') >= height(co2) / 2
        most_common_co2 = '1';
    else
        most_common_co2 = '0';
    end

    if sum(oxygen(:, i) == '1') >= height(oxygen) / 2
        most_common_oxygen = '1';
    else
        most_common_oxygen = '0';
    end

    if and(~all(oxygen(:, i)-'0'), height(oxygen) ~= 1)
        oxygen = oxygen((oxygen(:, i) == most_common_oxygen), :);
    end


    if height(co2) ~= 1 && ~all(co2(:, i)-'0')
        co2 = co2((co2(:, i) ~= most_common_co2), :);
    end
end

oxygen = bin2dec(sprintf("%s", oxygen));
co2 = bin2dec(sprintf("%s", co2));
display(oxygen*co2);