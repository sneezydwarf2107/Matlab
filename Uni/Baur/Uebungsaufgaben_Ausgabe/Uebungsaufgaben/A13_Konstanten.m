% M-Dateiname: "A13_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017

% Initialisierung
clc;
clear;

%% Motorparameter DC-Motor 
% PN=15W, UN=24V, nN=5.110U/min, MiN=26.1mNm
UN = 24;                % Nennspannung [V]
Umax = 24;              % Maximale Motorspannung [V]
Imax = 4.81;            % Maximaler Ankerstrom [A]
nmax = 99;              % maximale Drehzahl [1/s]
RA = 4.99;              % Ankerwiderstand [Ohm]
LA = 4.64e-4;           % Ankerinduktivität [H]
KM = 38.4e-3;           % Drehmomentkonstante [Nm/A]
KN = 1/(2*pi*KM);       % Drehzahlkonstante [1/(Vs)]
JR = 1.32e-6;           % Rotorträgheitsmoment [kgm^2]
CM = 7.1e-7;            % Reibkoeffizient Motorlager [Nms]
TA = LA/RA;              % Motorzeitkonstante [s]

%% Mechanikkomponente
R = 0.04;               % Radius Zahnriemenscheibe [m]
CF = 1e4;               % mittlere Federkonstante Zahnriemen [N/m]
FReib = 0.5;            % Reibkraft der Linearführung (Trockene Reibung) [N]
CR = 0.2;               % Reibkoeffizient viskose Reibung Linearführung [Ns/m]
m1 = 1;                 % Lastmasse [kg]
Ue = 4;                 % Getriebeuntersetzung [1]
WGrad = 0.85;           % Wirkungsgrad Planetengetriebe [1]
JG = 6e-8;              % Trägheitsmoment Planetengetriebe [kgm^2]

% Motorseitiges Trägheitsmoment ohne Last (bereits translatorisch berücksichtigt) [kgm^2]
JM = JR + JG

% Reduziertes Trägheitsmoment an der Motorwelle [kgm^2]
% gilt nur bei starrer Lastkopplung an Motorwelle
JRED = JR + JG + m1*R^2/(Ue^2*WGrad)          