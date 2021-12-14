% process_flash(1,5,5);

fid = fopen('input11.txt', 'rt');
data = textscan(fid, '%s');
fclose(fid);
data = char(data{1}) - '0';

% width = width(data);
% height = height(data);

[height, width] = size(data);
N_elem = numel(data);



% data = zeros([6,5]);
% data(6) = 9;
% data(3,4) = 9;

flash_tot = 0;
i=0;
% for i=1:100
while ~all(data == data(1))
    i=i+1;

%     for j=1:height
%         disp(join(string(data(j,:)),""))
%     end
%     disp(" ")
       
    data = data + 1;
    to_check = find(data>9);
    checked = [];
    while ~isempty(to_check)
        add = arrayfun(@(x) process_flash(x,width,height, data), to_check, 'UniformOutput', false);
        for j=1:numel(add)
            data(add{j}) = data(add{j}) + 1;
        end
        checked = [checked; to_check];
        to_check = setdiff(find(data>9), checked);
    end
    
    flashers = data > 9;
    flash_tot = flash_tot + nnz(flashers);
    
    data(flashers) = 0;
    if i==100
        disp(flash_tot)
    end
end
disp(i)
% disp(flash_tot)

function diff_locs=process_flash(loc, width, height, data)
loc = loc - 1;

y = mod(loc,height);
x = floor(loc/height);

if x>0 && x<width-1
    if y>0 && y<height-1
        right = loc+height;
        left = loc-height;
        diff_locs = [right-1,right,right+1,loc-1,loc+1,left-1,left,left+1];
    elseif y==0
        left = loc - height;
        right = loc+height;
        diff_locs = [left,left+1,loc+1,right,right+1];
    else % y==height-1
        left = loc - height;
        right = loc+height;
        diff_locs = [left-1,left,loc-1,right-1,right];
    end
elseif x==0
    if y>0 && y<height-1
        right = loc+height;
        diff_locs = [loc-1,loc+1, right-1,right,right+1];
    elseif y==0
        right = loc+height;
        diff_locs = [loc+1,right,right+1];
    else % y==height-1
        right = loc+height;
        diff_locs = [loc-1, right,right-1,];
    end
elseif x==width-1
    if y>0 && y<height-1
        left = loc - height;
        diff_locs = [left-1,left, left+1,loc-1,loc+1];
    elseif y==0
        left = loc-height;
        diff_locs = [left,left+1,loc+1];
    else % y==height-1
        left = loc-height;
        diff_locs = [left-1,left,loc-1];
    end
end

diff_locs = diff_locs + 1;
end