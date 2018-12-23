%Eine Funktion Priemzahlen(G) die bis zum bestimmten Grenzwert(G)
%alle Priemzahlen bestimmt.

function Priemzahlen (G)
    
    Zahlen = 2:G;
    x=0;
    y=1;
    
    for j=1:+1:G-1
        if Zahlen(j)~=0
            f=Zahlen(j);
        end
        
        for d=j+1:+1:G-(j)
            
            if mod(Zahlen(d),f)==0
                Zahlen(d)=0;
            end
        end
    end
    
    for v=1:+1:G-1
        if Zahlen(v)~=0
            x=x+1;
        end
    end
    
    endZahlen = 1:x;
    
    for v=1:+1:G-1
        if Zahlen(v)~=0
            
            endZahlen(y)=Zahlen(v);
            y=y+1;
        end
    end
   
    disp('Die Matrix lauted:')
    disp(endZahlen)
    
    
end
    