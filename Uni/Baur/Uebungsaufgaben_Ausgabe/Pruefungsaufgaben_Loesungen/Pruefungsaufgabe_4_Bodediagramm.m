% M-Dateiname: "Pruefungsaufgabe_4_Bode-Diagramm.m"
% Autor: J. Baur
% Datum: 01.07.2017

clc;
clear;

w  = [0.01 0.1 0.8 2 10];

% Amplitudengang
A = sqrt(4+4*w.^2) ./ sqrt( (2-2*w.^2).^2 + (w-w.^3).^2 )

% Phasengang
Imaginaerteil = 6*w - 6*w.^3
Realteil = -4 + 6*w.^2 - 2*w.^4
Phi = 180*atan2(Imaginaerteil,Realteil)/pi
