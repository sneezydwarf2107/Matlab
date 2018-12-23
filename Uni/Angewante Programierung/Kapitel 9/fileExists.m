function res = fileExists(filename)

fid = fopen(filename, 'r');

if fid < 0
    fprintf('\n\nDatei: %s, wurde nicht gefunden!\n',filename);
    res = 0;
else
    fprintf('\n\nDatei: %s, wurde gefunden!\n',filename);
    res = 1;
    fclose(fid);
end
end

