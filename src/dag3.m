fid = fopen('input3.txt', 'rt');
data = textscan(fid, '%s', 'HeaderLines', 0, 'CollectOutput', true);
fclose(fid);
clear fid

array = arrayfun(@str2num, cell2mat(string(data{:})));

% part 1
gamma = mode(array);
epsilon = bin2dec(num2str(~(gamma)));
gamma = bin2dec(num2str(gamma));
display(gamma*epsilon);

% part 2
most_common = mode(array(:, 1));
oxygen = array((array(:, 1) == most_common), :);
co2 = array((array(:, 1) ~= most_common), :);
for i = 2:width(array)
    most_common_co2 = mode(co2(:, i));
    most_common_oxygen = mode(oxygen(:, i));

    if and(~all(oxygen(:, i)), height(oxygen ~= 1))
        if height(oxygen(oxygen(:, i) == most_common_oxygen, :)) == (height(oxygen) / 2)
            most_common_oxygen = 1;
        end
        oxygen = oxygen((oxygen(:, i) == most_common_oxygen), :);
    end


    if and(~all(co2(:, i)), height(co2) ~= 1)
        if height(co2(co2(:, i) ~= most_common_co2, :)) == (height(co2) / 2)
            most_common_co2 = 1;
        end
        co2 = co2((co2(:, i) ~= most_common_co2), :);
    end
end

oxygen = bin2dec(num2str(oxygen));
co2 = bin2dec(num2str(co2));
disp(oxygen*co2);