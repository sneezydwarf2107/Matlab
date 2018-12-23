function d = linTransf(w,v,t)
    %% Bercechnung
    A=[cos(w),-sin(w);sin(w),cos(w)];
    d=A*v;
    d=d+t;
    
    %% Anzeige
    %figure
    clf
    max_val = max (v)+1;
    axis([-max_val max_val -max_val max_val]);
    grid on
    hold on
    line([0 v(1)],[0 v(2)],'LineWidth',3,'Color',[0 0 1]);
    line([0 d(1)],[0 d(2)],'LineWidth',3,'Color',[0 1 0]);
    legend('Ausgangsvektor', 'Ergebnisvektor');
end
