data = readtable('./input2.txt');

instructions = string(data.Var1);
up = sum(data.Var2(instructions == "up"));
down = sum(data.Var2(instructions == "down"));
forward = sum(data.Var2(instructions == "forward"));

vertical = down - up;
horizontal = forward;
disp(vertical*horizontal);

% part 2
mag = data.Var2;
aim = 0;
pos = 0;
dept = 0;
for i = 1:numel(instructions)
    switch instructions(i)
        case "up"
            aim = aim - mag(i);
        case "down"
            aim = aim + mag(i);
        case "forward"
            pos = pos + mag(i);
            dept = dept + mag(i) * aim;
    end
end
disp(num2str(pos*dept));