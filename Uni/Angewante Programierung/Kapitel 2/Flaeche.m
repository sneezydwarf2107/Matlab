
%Berechnen der Kreisflaeche durch eingabe des Radius 
function F=Flaeche(msg)
    r=input(msg)
    F = pi * (r.^2);
    v=round(F,2)
    round(v,2)
    fprintf('die Flaeche betraegt %f mm^2\n',v); 
end