function x2 = fcn(x1)

if x1 <= 0
    x2 = 0;
else
    if x1 >= 4
        x2 = 0;
    else
        x2 = 1+cos(2*pi*(x1/4));
    end
end
end