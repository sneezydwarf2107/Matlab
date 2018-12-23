% M-Dateiname: "A8_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017
% Löschen des Command Window
clc;
% Löschen des Workspace
clear;

%% Definition der Konstanten
P = 0.02;       % Spindelsteigung [m]
CF = 1e7;       % Spindelmutter Zug/Drucksteifigkeit [N/m] entspricht CF = 1 N/um
CD = 20;        % Dämpfungskonstante [Ns/m]
m1 = 20;        % Lastmasse [kg]

%% Pol-Nullstellendarstellung
w0 = sqrt(CF/m1);
D = CD/(2*sqrt(CF*m1));
% Proportionalkonstante
K = P*CD/(2*pi*m1);
% Nullstelle
q1 = -CF/CD
% Polstellen
p1 =-D*w0 + j*w0*sqrt(1-D^2)
p2 =-D*w0 - j*w0*sqrt(1-D^2)
p3 = 0