%DateiSchreiben

Dateiname = 'Test.txt';
fid=fopen( Dateiname, 'w');
if fid<0
    fprintf('Kann Datei: %s nicht öffnen!\n', Dateiname)
    return
end

fprintf ('Geben sie nun 5 Zeilen ein: \n')

for n=1 :5
    Zeile = input('->: ','s');
    fprintf(fid, '%s\n', Zeile);
end
fclose(fid);