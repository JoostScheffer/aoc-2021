% fid = fopen('test10.txt', 'rt');
fid = fopen('input10.txt', 'rt');
data = textscan(fid, '%s');
fclose(fid);


data = data{:};
N_lines = numel(data);
points = 0;
tot_points_2 = [];
for i = 1:N_lines
    line = data{i};
    N_chars = strlength(line);
    open = [];
    no_error = true;

    for j = 1:N_chars
        curr_char = line(j);
        if curr_char == '(' || curr_char == '[' || curr_char == '{' || curr_char == '<'
            open = [open; complement(curr_char)];
        elseif curr_char == ')' || curr_char == ']' || curr_char == '}' || curr_char == '>'
            if open(end) == curr_char
                open = open(1:end-1);
            else
%                 disp(line + " expected " + open(end) + ", but found " + curr_char + " instead")
                points = points + score(curr_char);
                no_error = false;
                break
            end
        else
            if ~isempty(open)
                disp("illegal expected "+open(end)+", but found "+curr_char+" instead")
            else
                disp("illegal, found "+curr_char+"")
            end
        end
    end
    
    % part 2
    if no_error
        autocomplete = fliplr(open.');
        points_2 = 0;
        for j = 1:numel(autocomplete)
            points_2 = points_2 * 5 + score_2(autocomplete(j));
        end
        tot_points_2 = [tot_points_2; points_2];
    end
end

disp(points)
fprintf("\t%d\n", median(tot_points_2))

function comp_char = complement(in_char)
switch (in_char)
    case '('
        comp_char = ')';
    case '['
        comp_char = ']';
    case '<'
        comp_char = '>';
    case '{'
        comp_char = '}';
end
end

function points = score(in_char)
switch (in_char)
    case ')'
        points = 3;
    case ']'
        points = 57;
    case '>'
        points = 25137;
    case '}'
        points = 1197;
end
end


function points = score_2(in_char)
switch (in_char)
    case ')'
        points = 1;
    case ']'
        points = 2;
    case '>'
        points = 4;
    case '}'
        points = 3;
end
end