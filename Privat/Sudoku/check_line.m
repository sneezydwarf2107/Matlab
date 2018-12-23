%Checks the line beside and below v(n,m)for doubles on "a". Returns 1 if there is a double. 
function [check] = check_line(v,n,m,a)

    check=3;
    for x=1:9
       if v(x,m)==a
           check=1;
           return
       end
       
       if v(n,x)==a
           check=1;
           return
       end 
    end
    if check==3
        check=0;
    end
end