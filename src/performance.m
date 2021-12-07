N = 7;
% name = "dag" + string(1:N) + ".m";
% result = runperf(name);
% disp(mean(result.TestActivity.MeasuredTime(result.TestActivity.Objective == "sample")));
disp("day | total time (ms)")
for i = 1:N
    name = "dag" + i + ".m";
    [T, result] = evalc('runperf(name);');
    disp(i + "   | " + mean(result.TestActivity.MeasuredTime(result.TestActivity.Objective == "sample"))*1e3);
end
% arrayfun(@(x) x.MeasuredTime(x.Objective == "sample"), result)