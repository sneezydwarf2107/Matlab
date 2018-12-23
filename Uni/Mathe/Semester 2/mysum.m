function [s]= mysum(x)

    if nargin==0
       x=1:10; 
        
    end
    n = length(x);
    s=0;
    for k=1:n
        s=s+x(k);
    
    end

end