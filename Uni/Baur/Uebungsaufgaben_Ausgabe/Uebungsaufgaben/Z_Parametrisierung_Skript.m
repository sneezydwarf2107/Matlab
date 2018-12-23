% M-Dateiname: "Z_Parametrisierung_Skript.m"
% Definition der Systemparameter über Base Workspace
% Autor: J. Baur
% Datum: 01.07.2017

% Initialisierung
clc;
clear('all');       % Löschen aller Datenobjekte
close('all');       % Löschen alter Plot-Diagramme
mdlname = 'Z_Parametrisierung';

% Simulink-Modell in einem neuen Fenster öffnen
open(mdlname)

% Einstellung der Simulationsparameter
load_system(mdlname);

% Umstellung auf Fixed-Step Mode bei mehreren Zeit-Plots
set_param(mdlname,'Solver','ode3','FixedStep','0.001');
w = logspace(-3,4,1000);    % Frequenzbereich mit logspace(10^a,10^b,Anzahl)
% Festlegung von sys_io (INPUT- und OUTPUT-POINT)
sys_io(1)=linio('Z_Parametrisierung/Sum',1,'in');
sys_io(1).OpenLoop = 'on';      % Auftrennung fuer Open-Loop Simulation
sys_io(2)=linio('Z_Parametrisierung/Regelstrecke',1,'out');
sys_io(2).OpenLoop = 'on';      % Auftrennung fuer Open-Loop Simulation
% Ubertragung der Konfiguration an das Modell
setlinio(mdlname,sys_io);

% Systemparameter definieren
% Regelparameter
CR = [0.5,1,5];    
[m,LOOP] = size(CR);   % Anzahl Schleifendurchlaeufe berechnen
M1 = 0.5;
CF = 1;

% Systemparameter abspeichern
save_system(mdlname);

% Alle Blöcke des Modells auflisten
find_system(mdlname,'type','block')
% Verfügbare Parameter eines Simulink-Blockes anzeigen
get_param('Z_Parametrisierung/Regelstrecke','DialogParameters')

% Parametrisierte Lineare Analyse und Zeitsimulation
for k=1:LOOP
    % Setzen von Systemparametern
    set_param('Z_Parametrisierung/Regelstrecke','Numerator','[4]');  
    set_param('Z_Parametrisierung/Regelstrecke','Denominator','[M1 CR(k) CF]');        
     
    % Simulation im Frequenzbereich zwischen INPUT- und OUTPUT-POINT
    % Linearisierung des Modells erzeugt die Systemmatrizen "linsys"
    linsys = linearize(mdlname,sys_io);
    
    % Umwandlung der Systemmatrizen des Modells in das
    % kontinuierliche LTI-Zustandsmodell mit [Zaehler],[Nenner]
    % Zustandsraumdarstellung
    sys(k) = ss(linsys);
    
    % Ausgabe der Übertragungsfunktion im command window
    tf(sys(k))
    
    % Simulation im Zeitbereich zwischen IN- und OUT-Bloecken
    % Beachte: Solver-Umstellung auf Fixed-Step Mode
    % bei Plot von mehreren Signalen in einem Diagramm
    % WICHTIG: IN- und OUT Block muss gesetzt sein!
    [t,x,y] = sim(mdlname,[0,20]);
    if k==1
        [m,n] = size(y);
        z = zeros(m,n+LOOP-1);
    end;
    z(:,k) = y(:,1);
end;

% Plot Linear Analysis (bode, step, impulse, pzmap, ...)
set(0,'ShowHiddenHandles','on');
ltiview({'bode'},sys(1),sys(2),sys(3),w);   % w = Frequenzbereich
legend('show');

% Plot der Zeitsimulation
figure;
plot(t,z(:,1),t,z(:,2),t,z(:,3));
legend('show');
% legend('Signal 1','Signal 2','Signal 3')
title('Signale im Zeitbereich')

% Grid fuer alle Plots einschalten
objects = findobj('Type','axes');
for index = 1:length(objects)
    grid(objects(index),'on');
end

% Systemparameter und Simulink-Modell abspeichern und schliessen
save_system(mdlname);
close_system(mdlname');