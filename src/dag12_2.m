data = importdata('input12.txt');
% data = importdata('test12_1.txt');
data = split(data, '-');

%%
G = graph(data(:, 1), data(:, 2));
start_node = find(strcmp(G.Nodes.Name, 'start'));

adj_mat = {};
for i = 1:numel(G.Nodes)
    adj_mat{end+1} = neighbors(G, i);
end

tic
result1 = walk(adj_mat, G.Nodes.Name, start_node, [], [], false)
toc
tic
result2 = walk(adj_mat, G.Nodes.Name, start_node, [], [], true)
toc

%%
function N_valid = walk(adj_mat, names, curr_node, seen, revisited, is_part2)
name = names{curr_node};

if strcmp(name, 'end')
    N_valid = true;
    return
end

if is_part2 && strcmp(name, 'start') && any(curr_node == seen)
    N_valid = false;
    return
end

if any(curr_node == seen) && is_lower(name)
    if is_part2 && isempty(revisited)
        revisited = 1;
    else
        N_valid = false;
        return
    end
end

counter = 0;
seen = union(seen, curr_node);
for i = adj_mat{curr_node}'
    counter = counter + walk(adj_mat, names, i, seen, revisited, is_part2);
end

N_valid = counter;
end

%%
function result = is_lower(name)
result = all(isstrprop(name, 'lower'));
end