clear

%% read input
fid = fopen('input21.txt');
data = textscan(fid, 'Player %d starting position: %d', 'CollectOutput', true);
fclose(fid);


%% part 1
pos = data{1}(:,2);
score = [0 0];
N_rolls = 0;

while all(score < 1000)
    N_rolls = N_rolls + 3;
    steps = 3*(N_rolls - 1);
    turn = 2 - (mod(N_rolls,6)/3 == 1);
    pos(turn) = mod((pos(turn) + steps)-1,10)+1;
    score(turn) = score(turn) + pos(turn);
end

sol1 = N_rolls * min(score)

%% part 2
pos = data{1}(:,2);
