fid = fopen('input4.txt', 'rt');
data = textscan(fid, '%s', 'HeaderLines', 0, 'CollectOutput', true);
fclose(fid);
clear fid


lines = height(data{1});
callout = arrayfun(@str2num, string(split(data{1}(1), ',')));
N_sudokus = (lines - 1) / 25;

sudos = reshape(arrayfun(@str2num, string(data{1}(2:lines))), [5, 5, N_sudokus]);
sudos = reshape(cell2mat(arrayfun(@(x) transpose(sudos(:, :, x)), 1:N_sudokus, 'UniformOutput', false)), [5, 5, N_sudokus]);

had = zeros([5, 5, N_sudokus]);
won = 0;

winner = 0;
winner1 = 0;

for i = 1:length(callout)
    had = had + (sudos == callout(i));

    % check if a sudoku is finished
    vertical = any(all(had));
    horizontal = any(all(had, 2));

    winner = unique(vertcat(find(horizontal), find(vertical)));
    if ~isempty(winner) && winner1 == 0
        winner1 = winner;
        i1 = i;
        had1 = had(:, :, winner1);
    end

    if length(winner) == (N_sudokus)
        winner2 = setdiff(winner, prev_winner);
        break;
    end
    prev_winner = winner;
end

display(sum(sum(sudos(:, :, winner1).* ~had1))*callout(i1))
display(sum(sum(sudos(:, :, winner2).* ~had(:, :, winner2)))*callout(i))