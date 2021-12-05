fid = fopen('test5.txt', 'rt');
data = cell2mat(textscan(fid, '%f,%f -> %f,%f', 'HeaderLines', 0));
fclose(fid);

maxi = max(max(data)) + 1;

grid = zeros([maxi, maxi]);

for i = 1:numel(data(:, 1))
    x_range = sort(data(i, 1:2:3));
    y_range = sort(data(i, 2:2:4));
    y_1 = x_range(1) + 1;
    y_2 = x_range(2) + 1;
    x_1 = y_range(1) + 1;
    x_2 = y_range(2) + 1;
    if (x_1 == x_2 || y_1 == y_2)
        grid(x_1:x_2, y_1:y_2) = grid(x_1:x_2, y_1:y_2) + 1;
    else
        x_range = data(i, 1:2:3);
        y_range = data(i, 2:2:4);

        x_1 = x_range(1) + 1;
        x_2 = x_range(2) + 1;
        y_1 = y_range(1) + 1;
        y_2 = y_range(2) + 1;

        x_ran = linspace(x_1, x_2, range(x_range)+1);
        y_ran = linspace(y_1, y_2, range(y_range)+1);

        select = y_ran + (x_ran - 1) * maxi;
        grid(select) = grid(select) + 1;
    end
end

% for i = 1:maxi
%     disp(join(replace(string(grid(i, 1:10)), "0", "."), ""))
% end

display(sum(sum(grid >=2)))