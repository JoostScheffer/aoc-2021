data = load("./input1.txt");

disp(sum(diff(data) > 0))

vector = movsum(data, 3);
vector = vector(2:end);

disp(sum(diff(vector) > 0))