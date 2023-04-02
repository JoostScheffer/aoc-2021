clear

%% read input
fid = fopen('input14.txt', 'rt');
reeks = fgetl(fid);
instructions = char(textscan(fid, '%c%c -> %c', 'HeaderLines', 1, 'CollectOutput', true));
fclose(fid);

pat = string(instructions(:, 1:2));
result = [string(instructions(:, [1, 3])), string(instructions(:, [3, 2]))];

% sort
[pat, indeces] = sort(pat);
result = result(indeces, :);

%% building the matrix and vector
% pos_combs = unique([pat, result]);
% pat = pos_combs;
M = zeros(numel(pat));
init_vec = zeros([1, numel(pat)]);
for i = 1:numel(pat)
    patr = pat(i);
    M(i, :) = (pat == result(pat == patr, 1)) | (pat == result(pat == patr, 2));
    init_vec(pat == patr) = count(reeks, patr);
end

%% computation
end_result = init_vec * M^40;

%% turn endresult into counts of individual characters
letters = unique(char(pat));
counts = zeros(numel(letters), 1);
for i = 1:numel(init_vec)
    pair = char(pat(i));
    count = end_result(i);
    % for each pair add the frequency of that pair to the frequency of the
    % first letter of that pair
    counts(letters == pair(1)) = counts(letters == pair(1)) + count;
%     counts(letters == pair(2)) = counts(letters == pair(2)) + count;
end
% add 1 extra for the last letter
counts(letters == reeks(end)) = counts(letters == reeks(end)) + 1;

sol = string(range(counts))