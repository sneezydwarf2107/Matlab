% M-Dateiname: "Pruefungsaufgabe_15_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017

% Initialisierung
clc;
clear;

% Systemparameter definieren
% Motorparameter DC-Motor PN=15W
RA = 5;                 % Ankerwiderstand [Ohm]
KM = 50e-3;             % Drehmomentkonstante [Nm/A]

% Mechanikkomponente
R = 0.02;               % Radius Zahnriemenscheibe [m]
CR = 2;                 % Reibkoeffizient viskose Reibung Linearführung [Ns/m]
m1 = 4;                 % Lastmasse [kg]
Ue = 2;                 % Getriebeuntersetzung [1]
WGrad = 0.9;            % Wirkungsgrad Planetengetriebe [1]

% Reduziertes Trägheitsmoment an der Motorwelle [kgm^2]
% gilt nur bei starrer Lastkopplung an Motorwelle
JRED = m1*R^2/(Ue^2*WGrad)              