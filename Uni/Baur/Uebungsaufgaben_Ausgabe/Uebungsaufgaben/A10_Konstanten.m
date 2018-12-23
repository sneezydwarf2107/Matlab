% M-Dateiname: "A10_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017

% Initialisierung
clc;
clear;

%% Motorparameter DC-Motor 
% PN=15W, UN=24V, nN=5.110U/min, MiN=26.1mNm
Umax = 24;              % Maximale Motorspannung [V]
Imax = 4.81;            % Maximaler Ankerstrom [A]
nmax = 99;              % maximale Drehzahl [1/s]
RA = 4.99;              % Ankerwiderstand [Ohm]
LA = 4.64e-4;           % Ankerinduktivität [H]
KM = 38.4e-3;           % Drehmomentkonstante [Nm/A]
KN = 1/(2*pi*KM);       % Drehzahlkonstante [1/(Vs)]
JR = 1.32e-6;           % Rotorträgheitsmoment [kgm^2]
CM = 7.1e-7;            % Reibkoeffizient Motorlager [Nms]

%% Mechanikkomponente
JL = 2e-4;              % Lasttraegheitsmoment [kgm^2]
R = 0.02;               % Radius der Zahnriemenscheibe [m]
MW = 0;                 % Widerstandsmoment [Nm]