function d = Drehung(w,v)

    A=[cos(w),-sin(w);sin(w),cos(w)];
    d=A*v;
end
