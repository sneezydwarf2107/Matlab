%Reads out the preedefinied numbers of the 9x9 Matrix. 
function [s]= read_safe (v)

    s=zeros(2,81);
    b=1;

    for x=1:9
        for y=1:9
            if v(x,y)~=0
                for a=1:2
                    if a==1
                        s(a,b)=x;   
                    end

                    if a==2
                        s(a,b)=y; 
                    end
                end
                b=b+1;
            end
        end
    end
end