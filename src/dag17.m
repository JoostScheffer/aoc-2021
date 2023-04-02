clear

%%
x_max = 164;
x_min = 117;
y_max = -140;
y_min = -89;

x_max = 30;
x_min = 20;
y_max = -10;
y_min = -5;

y_maxi = 0;

addr = 0;
check = [];
for Dx = 1:400
    for Dy = -200:400
%         if Dy == 0 && Dx == 6
%             disp("p")
%         end
        y_pos = 0;
        x_pos = 0;
        y_vel = Dy;
        x_vel = Dx;
        while y_pos > y_max && x_pos <= x_max
%             if Dx == 7 && Dy == 6
%                 disp(1)
%             end
            y_pos = y_pos + y_vel;
            x_pos = x_pos + x_vel;
            if x_vel == 0 && x_pos < x_min
                break
            end
            x_vel = (x_vel - 1)*((x_vel - 1) > 0);
            y_vel = y_vel - 1;
            if y_pos >= y_max && x_pos <= x_max && x_pos >= x_min && y_pos <= y_min
                if Dy > y_maxi
                    y_maxi = Dy;
                end
                addr = addr + 1;
                check = [check; [Dx, Dy]];
            end
        end
 
    end
end

% disp(y_maxi);
sol1 = sum(1:y_maxi)