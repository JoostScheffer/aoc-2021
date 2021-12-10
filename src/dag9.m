fid = fopen('input9.txt', 'rt');
data = textscan(fid, '%c');
fclose(fid);

width = 100;
b = data{1} - '0';
height = numel(b) / width;
data = reshape(b, [width, height]).';
% data = cell2mat(cellfun(@(x) x - '0', b, 'UniformOutput', false));

% right neighbour
right = data(:, 1:end-1) < data(:, 2:end);
% bottom neighbour
bot = data(1:end-1, :) < data(2:end, :);
[h, b] = size(data);
nul = zeros([h, b], 'logical');

nul(:, 1:end-1) = right;
nul(:, end) = ~right(:, end);
nul(:, 2:end) = nul(:, 2:end) & ~right;
nul(1:end-1, :) = nul(1:end-1, :) & bot;
nul(2:end, :) = nul(2:end, :) & ~bot;

N = sum(sum(nul)) + sum(sum(data(nul)));
disp(N);

% part 2
a = bwlabel(data ~= 9, 4);
disp(prod(maxk(arrayfun(@(x) nnz(a == x), 1:max(a, [], 'all')), 3)))

% alternative approach
% connected = bwconncomp(data~=9, 4);
% disp(prod(maxk(cellfun(@numel, connected.PixelIdxList), 3)))
% bwlabeln could also be used instead of bwlabel