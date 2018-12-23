function txt2html(ADatei)

    if nargin == 0
        clc
        clear
        ADatei= 'myFile.txt';
    end
    
    if fileExists(ADatei) == 1
        fid_IN = fopen( ADatei,'r');
        ADateineu = getfilenameHTML(ADatei);
        fid_OUT = fopen(ADateineu, 'w');
        
        fprintf(fid_OUT,'<HTML>\n');
        fprintf(fid_OUT,'<BODY>\n');
        fprintf(fid_OUT,'<HEAD>\n');
        fprintf(fid_OUT,'<TITLE>text2html</TITLE>\n');
        fprintf(fid_OUT,'</HEAD>\n');
        weiter = 1;
        while(weiter)
            Zeile = fgetl (fid_IN);

            if Zeile == -1
                weiter = 0;
            else
                fprintf(fid_OUT, '%s<br>\n',Zeile);
            end
        end
        
        fprintf(fid_OUT,'</BODY>\n');
        fprintf(fid_OUT,'</HTML>\n');
        fclose(fid_IN);
        fclose(fid_OUT);
    end
    