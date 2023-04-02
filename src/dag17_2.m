clear

%%
fid = fopen('input17.txt');
data = textscan(fid, 'target area: x=%d.%d, y=%d.%d');
fclose(fid);
[xmin, xmax, ymax, ymin] = data{:};

%%

works = [];
for Dx = 1:1000
    disp(Dx)

    for Dy = -1000:1000
        ddx = Dx;
        ddy = Dy;
        %%
        x = 0;
        y = 0;
        %%
        while x <= xmax && y >= ymax
            x = x + ddx;
            ddx = (ddx - 1) * ((ddx - 1) >= 0);
            
            y = y + ddy;
            ddy = ddy - 1;
            
            if x >= xmin && x <= xmax && y<=ymin && y>=ymax
                works = [works; Dx, Dy];
                break
            end
        end
    end
end