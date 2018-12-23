% M-Dateiname: "A_Modellierung_Konstanten.m"
% Verst�ndnisfrage 11 in Kapitel 3
% Autor: J. Baur
% Datum: 01.07.2017
clc
clear

%% Elektrische Konstanten
L1 = 1e-3;      % erste L�ngsinduktivit�t [H]
L2 = 1e-3;      % zweite L�ngsinduktivit�t [H]
C = 1e-3;       % Querkapazit�t [F]
R = 50;         % Abschlusswiderstand [Ohm]

%% Mechanische Konstanten
m1 = 1e3;       % Masse Schubfahrzeug [kg]
m2 = 2e2;       % Lastmasse [kg]
CF = 1e4;       % Federkonstante Schubstange [N/m]
CR = 1e2;       % viskose Reibung Schubbeh�lter auf Grund [Ns/m]