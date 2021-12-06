data = load("input6.txt");
num = histogram(data, 'BinEdges', -0.5:1:8.5).Values;

for i = 1:256
    num = circshift(num, -1);
    num(7) = num(7) + num(9);
    if i == 80
        disp(num2str(sum(num)))
    end
end
disp(num2str(sum(num)))