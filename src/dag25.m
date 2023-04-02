clear

%% input
fid = fopen('input25.txt', 'rt');
data = textscan(fid, '%s');
fclose(fid);
field = char(data{1});

%% processing
[H, W] = size(field);
S = H*W;
i = 0;
while true
    i = i + 1;
    %% east
    locs = find(field == '>');
    [R,C] = ind2sub([H,W], locs);
    C = C + 1;
    C(C == W+1) = 1;
    look = sub2ind([H, W],R,C);
    
    available_e = field(look) == '.';
    field(locs(available_e)) = '.';
    field(look(available_e)) = '>';

    %% south
    locs = find(field == 'v');
    [R,C] = ind2sub([H,W], locs);
    R = R + 1;
    R(R == H+1) = 1;
    look = sub2ind([H, W],R,C);
    
    available_s = field(look) == '.';
    field(locs(available_s)) = '.';
    field(look(available_s)) = 'v';
    
    %%
    if ~any(available_e) && ~any(available_s)
        sol1 = i
        break
    end
end