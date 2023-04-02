clear

%% read input
fid = fopen('input22.txt');
% instructions = textscan(fid, '%s x=%d..%d,y=%d..%d,z=%d..%d', 'CollectOutput', true);
data = textscan(fid, '%s x=%d.%d,y=%d.%d,z=%d.%d', 'CollectOutput', true);
fclose(fid);

states = string(data{1});
locs = data{2};
coll = [];
% C = containers.Map();
locs(locs > 50) = 50;
locs(locs < -50) = -50;
% locs(locs(:, 1:2:end) < -50) = -50;
% locs(locs(:, 2:2:end) > 50) = 50;

%% make vectors
V = [51, 51, 51];
for i = 1:numel(states)
    state = states(i);

    x = [locs(i, 1):locs(i, 2)];
    y = [locs(i, 3):locs(i, 4)];
    z = [locs(i, 5):locs(i, 6)];

    all_y = arrayfun(@(j) repmat(j, 1, numel(z)), y, 'UniformOutput', false);
    all_y = [all_y{:}];
    yz = [all_y; repmat(z, 1, numel(y))];

    all_x = arrayfun(@(i) repmat(i, 1, width(yz)), x, 'UniformOutput', false);
    all_x = [all_x{:}];
    xyz = [all_x', repmat(yz, 1, numel(x))'];
    if state == "on"
        V = union(V, xyz, 'rows');
    else
        V = setdiff(V, xyz, 'rows');
    end

end
sol1 = height(V(all(V<=50,2)))
%%
% if state == "on"
%         for x = locs(i, 1):locs(i, 2)
%             for y = locs(i, 3):locs(i, 4)
%                 for z = locs(i, 5):locs(i, 6)
%
%                     coll = [coll, [x,y,z]];
%
%                 end
%             end
%         end
%     else
%         for x = locs(i, 1):locs(i, 2)
%             for y = locs(i, 3):locs(i, 4)
%                 for z = locs(i, 5):locs(i, 6)
%
%                     coll = coll(coll~=[x,y,z]);
%
%                 end
%             end
%         end
%     end