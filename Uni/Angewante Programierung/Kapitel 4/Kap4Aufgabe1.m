function Kap4Aufgabe1()

    a=0;
    b=0;
    c=0;
    
    a=input('geben sie die Zahl a ein: ');
    b=input('geben sie die Zahl b ein: ');
    
    if a==0
        fprintf ('FEHLER: a wurde als 0 oder garnicht eingegeben\n\n')
    end
    
    if b==0
        fprintf ('FEHLER: b wurde als 0 oder garnicht eingegeben\n\n')
    end
    
    if a~=0&&b~=0
        c=a/b
        fprintf('succes c=%d\n',c)
    end