fid = fopen('input4.txt', 'rt');
callout = arrayfun(@str2num, split(string(fgetl(fid)), ','));
data = textscan(fid, '%f %f %f %f %f', 'HeaderLines', 0, 'CollectOutput', true);
fclose(fid);
clear fid

N_sudokus = numel(data{1}) / 25;
remaining_nums = 1:N_sudokus;


b = reshape(data{1}.', [5, 5, 100]);
sudos = reshape(cell2mat(arrayfun(@(x) transpose(b(:, :, x)), 1:100, 'UniformOutput', false)), [5, 5, 100]);

had = zeros([5, 5, N_sudokus]);
won = 0;

winners = [];
winner1 = 0;

for i = 1:length(callout)
    had = had + (sudos == callout(i));

    % check if a sudoku is finished
    vertical = any(all(had));
    horizontal = any(all(had, 2));

    winners = unique(vertcat(find(horizontal), find(vertical)));


    if ~isempty(winners) && winner1 == 0
        winner1 = winners;
        i1 = i;
        had1 = had(:, :, winner1);
    end

    if length(winners) == (N_sudokus)
        winners2 = setdiff(winners, prev_winners);
        break;
    end
    prev_winners = winners;
end

display(sum(sum(sudos(:, :, winner1).* ~had1))*callout(i1))
display(sum(sum(sudos(:, :, winners2).* ~had(:, :, winners2)))*callout(i))