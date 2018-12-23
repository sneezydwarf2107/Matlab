function check = control_square(v,n,m,y)
    %% Abfrage des Spaltenquadranten         
    if n<=3
        fprintf('Der Punkt liegt im Quadranten 1.');
        n=1;
    end



    if n>3 && n<=6 
        fprintf('Der Punkt liegt im Quadranten 2.');
        n=4;
    end




    if n>6 && n<=9 
        fprintf('Der Punkt liegt im Quadranten 3.');
        n=7;
    end

    
%% Abfrage des Zeilenquadranten    
    if m<=3
        fprintf('1\n');
        m=1;
    end



    if m>3 && m<=6 
        fprintf('2\n');
        m=4;
    end




    if m>6 && m<=9 
        fprintf('3\n');
        m=7;
    end
    
    %% Finden mehrerer Möglichkeiten
    check=0;
    p=0;
    for r=n:n+2
        for t=m:m+2
            if check_line(v,r,t,y)==0
                p=p+1;
            end
        end
    end
    if p==1
        check=1;
    end
end