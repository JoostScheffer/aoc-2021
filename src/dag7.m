data = sort(load("input7.txt"));
% data = sort(load("test7.txt"));

med = data(numel(data)/2);
fuel1 = sum(abs(data-med));
disp(fuel1)

% part 2
S = data(1);
L = data(numel(data));
range = L-S+1;
dist = abs(repmat(data,range,1) - (S:L).');
cost = sum(dist.*(dist+1)./2, 2);
[lowest, best] = min(cost);
disp(lowest)