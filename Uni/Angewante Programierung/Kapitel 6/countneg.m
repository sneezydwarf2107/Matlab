
function num = countneg(v)

    num=0;
    l=length(v);

    for s=1:+1:l
        
        if v(s) < 0
            num=num+1;
            
        end
    end
end
