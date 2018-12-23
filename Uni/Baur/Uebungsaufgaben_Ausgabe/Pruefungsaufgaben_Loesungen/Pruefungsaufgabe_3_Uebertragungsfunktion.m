% M-Dateiname: "Pruefungsaufgabe_3_Uebertragungsfunktion.m"
% Autor: J. Baur
% Datum: 01.07.2017

clc;
clear;

w  = 0.1:0.01:1000;  % Frequenzvektor mit
                     % Startwert:Schrittweite:Endwert
t  = 0:0.01:10;      % Zeitvektor mit
                     % Startwert:Schrittweite:Endwert

% Frequenzgang Gz(s) mit 2 Vektoren [Zähler],[Nenner] an tf.m übergeben
% [Zähler] = [bm bm-1 bm-2 ..b1 b0]
% [Nenner] = [an an-1 an-2 ..a1 a0]
G = tf([-1 2],[1 0 6])

% Darstellung der Sprungantwort (step.m)
subplot(111),step(G),title('Sprungantwort'),grid on;

% Darstellung im Bode-Diagramm (bode.m)
figure;
bode(G);
grid on;

% Darstellung im Pol-Nullstellenschema (pzmap.m)
figure;
pzmap(G);
sgrid;

% Berechnung der Pol- und Nullstellen (pole.m, zero.m)
% Ausgabe in Command Window
Polstellen = pole(G);
Nullstellen = zero(G);

% Analytische Loesungen
x2 = 1/3 - 0.3333*cos(sqrt(6)*t) - 0.4082*sin(sqrt(6)*t);
plot(t,x2)