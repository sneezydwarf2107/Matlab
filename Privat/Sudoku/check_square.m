%Prints out the squere matchinig to the Koordinate, then returnes 1 if
%there is any double for a. If not 0 is returned.
function c = check_square(v,n,m,a)

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
    
%% Prüfen auf doppelte

    for x=n:n+2
       for y=m:m+2
           if a==v(x,y)
               c=1;
               return
           end
       end
    end
    
    c=0;
end