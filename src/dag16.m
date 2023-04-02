clear

%% prime data
tic
fid = fopen('input16.txt', 'rt');
C = textscan(fid, '%c%c', 'CollectOutput', true);
fclose(fid);

tmp = cellfun(@hex2dec, C, 'UniformOutput', false);
tmp = cellfun(@dec2bin, tmp, 'UniformOutput', false);
tmp = [tmp{:}];
arr = tmp(:)';
toc

arr = '110100101111111000101000';
arr = '11101110000000001101010000001100100000100011000001100000';
[som, arr] = readPackage(arr, 0);


%% analysis part 1

function [som, arr] = readPackage(arr, som)
    if all(arr == 0)
        disp("gaat fout")
    end
    
    strtIdx = 1;
    
    packetVersion = bin2dec(arr(strtIdx: strtIdx+2));
    som = som + packetVersion;
    typeID = bin2dec(arr(strtIdx+3:strtIdx+5));
    if typeID==4 % literal value
        curs = strtIdx+6;
        chain = '';
        while arr(curs) ~= '0'
            chain = [chain, arr(curs+1:curs+4)];
            curs = curs + 5;
        end
        % process last number
        chain = [chain, arr(curs+1:curs+4)];
        startIdx = curs + 5;
        litVal = bin2dec(chain);
        
%         ans = litVal;
        arr = arr(startIdx:end);
    else
        lengthTypeID = arr(strtIdx+6)-'0';
        if lengthTypeID == 0
            %{
                the next 15 bits are a number that represents
                the total length in bits of
                the sub-packets contained by this packet.
            %}
            LSubP = bin2dec(arr(strtIdx+7:strtIdx+7+15-1));
            [som, ~] = readPackage(arr(strtIdx+23:strtIdx+23+LSubP-1), som);
            arr = arr(strtIdx+23+LSubP:end);
        else % lengthTypeID == 1
            %{
                the next 11 bits are a number that represents
                the number of sub-packets immediately
                contained by this packet.
            %}
            NSubP = bin2dec(arr(strtIdx+7:strtIdx+7+11-1));
            cursor = strtIdx+7+12;
            for i=1:3
                [som, arr] = readPackage(arr(cursor:end), som);
            end
            
            disp(1);
        end
    end
end