clear

tic
%% data priming
grid = char(readmatrix("input15.txt", 'OutputType', 'char'));
[w,h] = size(grid);
indeces = reshape(cumsum(ones(w*h,1), 'forward'), [w,h])';
G = digraph();
weigths = (grid-'0');


%% add all bottom neighbours
bots = indeces(2:end,:);
weigth = weigths(:, 2:end)';
inds = indeces(1:end-1,:);
for i=1:height(inds)
    G = addedge(G, inds(i,:), bots(i,:), weigth(i,:));
end

%% add all top neighbours
tops = indeces(1:end-1,:);
weigth = weigths(:,1:end-1)';
inds = indeces(2:end,:);
for i=1:height(inds)
    G = addedge(G, inds(i,:), tops(i,:), weigth(i,:));
end

%% add all right neighbours
rigs = indeces(:, 2:end);
weigth = weigths(2:end, :)';
inds = indeces(:,1:end-1);
for i=1:width(inds)
    G = addedge(G, inds(:,i), rigs(:,i), weigth(:,i));
end

%% add all left neighbours
lefs = indeces(:, 1:end-1);
weigth = weigths(1:end-1, :)';
inds = indeces(:,2:end);
for i=1:width(inds)
    G = addedge(G, inds(:,i), lefs(:,i), weigth(:,i));
end


%% part 1
% tic
nodes = shortestpath(G, 1, w*h, 'Method', 'positive');
tmp = weigths;
sol_1 = sum(tmp(nodes)) - tmp(1)
% toc
% ap = zeros(w,h);
% ap(nodes) = 1;
% imshow(~ap');

%% data priming for part 2
new_weigths = [];
for i=0:4
    tmp = mod(weigths+i, 9);
    tmp(tmp == 0) = 9;
    new_weigths = [new_weigths, tmp];
end
new_grid = [];
for i=0:4
    tmp = mod(new_weigths+i, 9);
    tmp(tmp == 0) = 9;
    new_grid = [new_grid; tmp];
end

%% part 2
grid = new_grid;
[w,h] = size(grid);
indeces = reshape(cumsum(ones(w*h,1), 'forward'), [w,h])'; % can be replaced with 1:w*h
G = digraph();
weigths = grid;

%% add all bottom neighbours
bots = indeces(2:end,:);
weigth = weigths(:, 2:end)';
inds = indeces(1:end-1,:);
for i=1:height(inds)
    G = addedge(G, inds(i,:), bots(i,:), weigth(i,:));
end

%% add all top neighbours
tops = indeces(1:end-1,:);
weigth = weigths(:,1:end-1)';
inds = indeces(2:end,:);
for i=1:height(inds)
    G = addedge(G, inds(i,:), tops(i,:), weigth(i,:));
end

%% add all right neighbours
rigs = indeces(:, 2:end);
weigth = weigths(2:end, :)';
inds = indeces(:,1:end-1);
for i=1:width(inds)
    G = addedge(G, inds(:,i), rigs(:,i), weigth(:,i));
end

%% add all left neighbours
lefs = indeces(:, 1:end-1);
weigth = weigths(1:end-1, :)';
inds = indeces(:,2:end);
for i=1:width(inds)
    G = addedge(G, inds(:,i), lefs(:,i), weigth(:,i));
end

%% exectute
% tic
nodes = shortestpath(G, 1, w*h, 'Method', 'positive');
tmp = weigths;
sol_2 = sum(tmp(nodes)) - tmp(1)
% toc
toc

ap = zeros(w,h);
ap(nodes) = 1;
imshow(~ap');