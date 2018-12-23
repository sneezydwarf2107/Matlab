% M-Dateiname: "Pruefungsaufgabe_10_Konstanten.m"
% M-Skript zur Definition der Konstanten
% Autor: J. Baur
% Datum: 01.07.2017
% L�schen aller Variablen im Workspace
clc
% L�schen des Command Window
clear

% Parameter DC-Motor (permanenterregt)
% Nennleistung PN = 15 W
% Nennmoment MiN = 26.1E-3 Nm
% Nennspannung UN = 24V
% Nennstrom IN = 0.691A
% Nenndrehzahl nN = 5110 U/min
% Leerlaufdrehzahl = nL = 5960 U/min
RA = 4.99;     % Ohmscher Ankerwiderstand [Ohm]
LA = 4.64E-4;  % Ankerinduktivitaet [H]
KM = 38.4E-3;  % Drehmomentkonstante [Nm/A]
KN = 1.5;      % Drehzahlkonstante [1/Vs] GE�NDERT!!!
JR = 1.32E-6;  % Massentraegheitsmoment des Rotors [kgm2]
CM = 7.1E-7;   % Reibkoeffizient der Motorlager [Nms]

JL = 1E-3;    % Tr�gheitsmoment der Last [kgm2]
Jges = JR + JL; % Gesamtes Massentr�gheitsmoment an der Antriebswelle