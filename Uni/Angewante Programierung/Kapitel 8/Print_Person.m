function d = Print_Person(num_pers)
    %% Datenerfassung
    for n=1 : num_pers
        Freunde(n).name = input('Name?    :', 's');
        Freunde(n).telnr = input('Telefonnummer?    :', 's');
    end
    d=Freunde;    
    %% Ausgabe der erfassten Daten
    home
    fprintf('Meine Freunde\n')
    fprintf('=============\n')
    for x=1 : num_pers
        fprintf('%s,%s\n',Freunde(x).name,Freunde(x).telnr);
    end
    
end
