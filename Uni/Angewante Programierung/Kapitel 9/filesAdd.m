function filesAdd( file1, file2, new_file )

%% Lesen des ersten und schreiben des neuen Files

fid = fopen(file1, 'r');
fid2 = fopen(new_file,'w');
if fid < 0
    fprintf('Datei: %s konnte nicht gefunden werden!\n', file1);
    return
end

weiter = 1;
while(weiter)
    Zeile = fgetl (fid);
    
    if Zeile == -1
        weiter = 0;
    else
        fprintf(fid2, '%s\n',Zeile);
    end
end
  
fclose(fid);
fclose(fid2);

%% Lesen des zweiten Files --> anhängen an neuen File

fid = fopen(file2, 'r');
fid2 = fopen(new_file, 'a');

if fid < 0 
    fprintf('Datei: %s konnte nicht gefunden werden!\n',file2);
    return
end

weiter = 1;
while (weiter)
    Zeile = fgetl (fid);
    
    if Zeile == -1
        weiter = 0;
    else
        fprintf(fid2,'%s\n',Zeile);
    end
end

fclose(fid);
fclose(fid2);