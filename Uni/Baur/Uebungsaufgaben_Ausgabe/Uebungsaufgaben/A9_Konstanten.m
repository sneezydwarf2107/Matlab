% M-Dateiname: "A9_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017
% Löschen des Command Window
clc;
% Löschen des Workspace
clear;

% Definition der Konstanten
P = 0.04;               % Spindelsteigung [m]
CF = 1e4;               % Kupplung Drehsteifigkeit [Nm/rad]
CD = 1e-1;              % Kupplung viskose Materialdaempfung [Nms/rad]
                        % CD = 0.1 / 1 / 10
CR = 1;                 % Viskose Reibung Linearfuehrung [Ns/m]
JR = 4e-3;              % Rotortraegheit [kgm^2]
JK = 1e-4;              % Kupplungstraegheit [kgm^2]
m2 = 70;                % Lastmasse [kg]
J2 = (P/(2*pi))^2*m2;   % Ersatztraegheit Last [kgm^2]