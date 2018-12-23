% M-Dateiname: "A_Modellierung_Konstanten.m"
% Verständnisfrage 11 in Kapitel 3
% Autor: J. Baur
% Datum: 01.07.2017
clc
clear

%% Elektrische Konstanten
L1 = 1e-3;      % erste Längsinduktivität [H]
L2 = 1e-3;      % zweite Längsinduktivität [H]
C = 1e-3;       % Querkapazität [F]
R = 50;         % Abschlusswiderstand [Ohm]

%% Mechanische Konstanten
m1 = 1e3;       % Masse Schubfahrzeug [kg]
m2 = 2e2;       % Lastmasse [kg]
CF = 1e4;       % Federkonstante Schubstange [N/m]
CR = 1e2;       % viskose Reibung Schubbehälter auf Grund [Ns/m]