N = 10;
disp("day | total time (ms)")
for i = 1:N
    if i~=8
        name = "dag" + i + ".m";
        [T, result] = evalc('runperf(name);');
        disp(i + "   | " + mean(result.TestActivity.MeasuredTime(result.TestActivity.Objective == "sample"))*1e3);
    end
end