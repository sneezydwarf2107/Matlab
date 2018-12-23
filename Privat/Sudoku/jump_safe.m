%Returnes 1 if v(a,b) shuld not be overwritten.In this case a&b are variables for the 
%aktual point of calculatin in the Matrix. Matrix v shuld be the matrix returned from 
%the funktion "read_safe".If a and b is not a marked field 0 is returned.

function j= jump_safe(a,b,v)
    j=3;

    for x=1:81
        if v(1,x)==a
            if v(2,x)==b
                j=1;
            end
        end
    end
    if j~=1
        j=0;
    end
end