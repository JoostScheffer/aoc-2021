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

winners = [];
winners1 = 0;

for i = 1:length(callout)
    had = had + (sudos == callout(i));

    % check if a sudoku is finished
    vertical = any(all(had));
    horizontal = any(all(had, 2));

    winners = unique(vertcat(find(horizontal), find(vertical)));
    if ~isempty(winners) && winners1 == 0
        winners1 = winners;
        i1 = i;
        had1 = had(:, :, winners1);
    end

    if length(winners) == (N_sudokus)
        winners2 = setdiff(winners, prev_winners);
        break;
    end
    prev_winners = winners;
end

display(sum(sum(sudos(:, :, winners1).* ~had1))*callout(i1))
display(sum(sum(sudos(:, :, winners2).* ~had(:, :, winners2)))*callout(i))