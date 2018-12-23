% M-Dateiname: "A17_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017

% Initialisierung
clc;
clear;

%% Parameter Lorentzaktuator Maccon CFC90-HF-20
% UN=120V, Fmax=500N, KF=50N/A, RM=4Ohm, max. Hub=20mm
Umax = 120;             % Maximale Statorspannung [V]
KF = 50;                % Kraftkonstante [N/A]
KV = 50;                % Gegen-EMK-Konstante [Vs/m]
LM = 0.01;              % Statorinduktivit�t [H]
RM = 4;                 % Statorspulenwiderstand [Ohm]


%% Mechanikkomponente
m1 = 4;                 % Lastmasse [kg]
m2 = 1;                 % Masse des L�ufers [kg]
CF = 5e4;               % Federkonstante [N/m]
CD = 100;               % D�mpfungskonstante [Ns/m]
CR = 100;               % Reibkonstante Linearf�hrung [Ns/m]
g = 9.81;               % Erdbeschleunigung [m/s^2]