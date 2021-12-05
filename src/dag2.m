fid = fopen('input2.txt', 'rt');
data = textscan(fid, '%s %d', 'HeaderLines', 0);
fclose(fid);

instructions = string(data{1});
mag = data{2};

up = sum(mag(instructions == "up"));
down = sum(mag(instructions == "down"));
forward = sum(mag(instructions == "forward"));

vertical = down - up;
horizontal = forward;
disp(vertical*horizontal);

% part 2
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