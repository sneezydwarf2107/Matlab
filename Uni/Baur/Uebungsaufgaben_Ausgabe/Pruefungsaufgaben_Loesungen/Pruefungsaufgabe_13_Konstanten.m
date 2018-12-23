% M-Dateiname: "Aufgabe_13_Konstanten.m"
% Autor: J. Baur
% Datum: 01.07.2017
% Löschen des Command Window
clc;
% Löschen des Workspace
clear;

% Definition der Systemparameter
m1 = 20;                                    % Lastmasse [kg]
ue = 10;                                    % Übersetzungsverhältnis Schneckengetriebe
Wgrad = 0.6;                                % Wirkungsgrad des Schneckengetriebes
P_Spindel = 0.006;                          % Spindelsteigung [m]
D_Spindel = 0.05;                           % Spindeldurchmesser [m]
KM = 0.05;                                  % Drehmomentkonstante des DC-Motors [NM/A]
alpha = atan(P_Spindel/(pi*D_Spindel))      % Steigungswinkel der Spindel (Grad)

% Alternatives Motormodell
LA = 2e-4;                                  % Ankerinduktivität [H]
RA = 0.6;                                   % Ankerwiderstand [Ohm]
Jges = 1e-7;                                % reduziertes Trägheitsmoment

% Fuer Bode-Diagramm
w = [0.1 , 1 , 10 , 20 , 40];
Amplitudengang = sqrt(23^2 + 46^2*w.^2) ./ sqrt(1e4*w.^4 + w.^6)
Imaginaerteil = -4577*w
Realteil = -2300 - 46*w.^2




