data = load("input6.txt");

num = zeros([1, 9]);
for i = 0:8
    num(i+1) = sum(data == i);
end

for i = 1:256
    num = circshift(num, -1);
    num(7) = num(7) + num(9);
    if i == 80
        fprintf('%d\n', sum(num))
    end
end
fprintf('%d\n', sum(num))
