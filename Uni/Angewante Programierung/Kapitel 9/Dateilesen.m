% Datei lesen

Datei = 'test.txt';
fid = fopen(Datei, 'r');

if fid < 0
    fprintf('Kann Datei: %s nicht öffnen!\n', Datei);
    return
end

weiter =1; 
while (weiter)
    Zeile = fgetl (fid);
    
    if Zeile ==-1
        weiter = 0;
    else
        
        fprintf ('%s\n',Zeile);
    end
end

fclose(fid);
