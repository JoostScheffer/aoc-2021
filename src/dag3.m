fid = fopen('input3.txt', 'rt');
data = textscan(fid, '%c');
fclose(fid);
clear fid

array = reshape((data{:}), [12,1000]).';

% part 1
gamma = mode(array);
epsilon = bin2dec(char(~(gamma - '0') + '0'));
gamma = bin2dec(gamma);
display(gamma*epsilon);

% part 2
most_common = mode(array(:, 1));
oxygen = array((array(:, 1) == most_common), :);
co2 = array((array(:, 1) ~= most_common), :);
for i = 2:width(array)
    most_common_co2 = mode(co2(:, i));
    most_common_oxygen = mode(oxygen(:, i));

    if and(~all(oxygen(:, i) - '0'), height(oxygen) ~= 1)
        if height(oxygen(oxygen(:, i) == most_common_oxygen, :)) == (height(oxygen) / 2)
            most_common_oxygen = '1';
        end
        oxygen = oxygen((oxygen(:, i) == most_common_oxygen), :);
    end


    if and(~all(co2(:, i) - '0'), height(co2) ~= 1)
        if height(co2(co2(:, i) ~= most_common_co2, :)) == (height(co2) / 2)
            most_common_co2 = '1';
        end
        co2 = co2((co2(:, i) ~= most_common_co2), :);
    end
end

oxygen = bin2dec(num2str(oxygen));
co2 = bin2dec(num2str(co2));
disp(oxygen*co2);