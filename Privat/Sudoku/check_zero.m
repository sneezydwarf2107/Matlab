%returns 0 if v(n,m)==0,return 1 if v(n,m)~=0.

function [ check ] = check_zero(v,n,m)
    if v(n,m)==0
        check=0;
        
    else
        check=1;
    end
end

