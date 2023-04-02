clc
clear
inputArray = readmatrix('input13.txt', 'OutputType', 'string');

%%
points = str2double(inputArray);
folds = inputArray(isnan(points(:, 1)), 1);
folds = arrayfun(@(s) sscanf(s, 'fold along %c=%d'), folds, 'UniformOutput', false);
points = points(~isnan(points(:, 1)), :);

range = flip(max(points)+1);
M = false(range);
M(sub2ind(range, points(:, 2)+1, points(:, 1)+1)) = 1;

%%
for i = 1:numel(folds)
    axis = folds{i}(1);
    index = folds{i}(2);

    if axis == 'x'
        wid = width(M) - index - 1;
        left = M(:, (index - wid + 1:index));
        right = M(:, index+2:end);
        M(:, index-wid+1:index) = left | flip(right, 2);
        M = M(:, 1:index);
    else
        hei = height(M) - index - 1;
        top = M(index-hei+1:index, :);
        bottom = M(index+2:end, :);
        M(index-hei+1:index, :) = top | flip(bottom);
        M = M(1:index, :);
    end

    if i == 1
        result1 = sum(M, 'all')
    end
end

figure
result2 = imshow(~M);
axis off image