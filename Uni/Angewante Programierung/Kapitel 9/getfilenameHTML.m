function erg = getfilenameHTML (aFile)

    if nargin == 0 
        clc
        clear
        aFile= 'Hallo.txt';
    end
    
    for i = length(aFile):-1:1
        c=aFile(i);
        if (c == '.')
            break
        end
    end
    
    rumpf = aFile(1:i);
    erg= [rumpf, 'html'];
end
