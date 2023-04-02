fid = fopen('test12_1.txt', 'rt');
data = textscan(fid, '%s%s', 'Delimiter', '-');
fclose(fid);

start_names = unique(data{1});
end_names = unique(data{2});
all_names = unique([start_names; end_names]);
% names = unique([data{1}, data{2}]);

% G = digraph();
G = graph();
G = addnode(G, numel(all_names));
G.Nodes.Name = all_names;

for i=1:numel(data{1})
    node_1 = data{1}(i);
    node_1 = node_1{1};
    node_2 = data{2}(i);
    node_2 = node_2{1};
    G = addedge(G, node_1, node_2);
end

% deg_1 = G.Nodes.Name((G.Nodes.Name ~= "end") & ~outdegree(G));
% deg_1 = G.Nodes.Name(degree(G)==1);
% for i=1:numel(deg_1)
%     name = deg_1{i};
%     neighbor = neighbors(G, name);
%     
%     neighbor = predecessors(G, name);
%     if all(isstrprop(neighbor,'upper')) 
%     G = addedge(G, name, neighbor);
% end