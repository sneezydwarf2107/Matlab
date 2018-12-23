function aufleitung = aufleitung_num(fkt,a,b,N)



    x=linspace(a,b,N);
    y=fkt(x);
    delta=((b-a)/N)*y;
    aufleitung=0;
    l=length(delta);
    
    for i=1:1:l
        aufleitung=aufleitung+delta(i);
    end
    
end