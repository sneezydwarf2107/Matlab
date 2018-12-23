function y= sudoku(v)
%% Set Defaults
    if nargin == 0
        v= ones(9,9);
    end
    shutdown =0;
    z=read_safe(v);
    g=0;
 %% Start Calculation
   while shutdown ~= 1
       for a=1:9
           for b=1:9
               if jump_safe(a,b,z)==0
                   zaehler=1;
                   while zaehler~=10
                       if check_line(v,a,b,zaehler)==0 && check_square(v,a,b,zaehler)==0 && control_square(v,a,b,zaehler)==1
                           v(a,b)=zaehler;
                           z=read_safe(v);
                           zaehler=10;
                           g=g+1;
                       else
                           zaehler=zaehler+1;
                       end
                   end
               end
           end
       end 
   end
end