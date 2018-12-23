% M-Dateiname: "IFFT_Analyse.m"
% Schnelle inverse Fouriertransformation IFFT (Inverse Fourieranalyse)
% Spektralfunktion mit Frequenz- und Spektralwertspalte
% Übernahme der komplexen Spektrallinien X_m (Real- und Imaginärteil) 
% und Frequenz f vom Workspace oder über Datei 
% Anmerkung:  Fourierreihenentwicklung erfolgt mit der reellen Darstellung
% x(t) = X0 + 2*Summe(|X_m|*cos(2*pi*m*f0*t+phi_m))  mit m=1,2,....,inf
% Autor: J. Baur
% Datum: 01.07.2017
% Löschen des Command Window
clc;

% Eingabe der Datenquelle für Spektrallinien
Datenquelle = ' ';
disp('Beachte:  Nur für das vollständige Signal (ohne Option Zeitausschnitt) sinnvoll.');
disp('');
disp('1. Festlegung der Datenquelle mit 2 Spalten ==> (Frequenz und komplexe Spektrallinien)');
disp('Wichtig: Anzahl der Spektrallinien muss Zweierpotenz sein!');
while (Datenquelle~='d')&(Datenquelle~='w')
    Datenquelle = input('Wählen Sie Datei [d] oder Workspace [w]: ','s');
    switch Datenquelle
        case 'd'
            % Einlesen einer ASCII-Datei von Laufwerk/Festplatte
            disp('Eingabe des Dateinamens mit Pfad (aktueller Ordner mit .\)');
            Dateiname = input('Dateiname : ','s');
            % Einlesen in den Vektoren: Frequenz und komplexe Spektrallinien
            Daten_in = dlmread(Dateiname,' ',0,0);
            f = Daten_in(:,1);          % Einlesen der N Frequenzwerte
            X_m = Daten_in(:,2);        % Einlesen der N Spektralwerte
        case 'w'
            % Einlesen des komplexen Spektrums über das Command Window 
            % als Spaltenvektoren f und X (mit Real- und Imaginärteil)
            disp('Direkte Übernahme der beiden Spaltenvektoren');
            disp('"Frequenz(m)" und der komplexen Spektrallinien "X(m)"');
        otherwise
            disp('Falsche Eingabe!');
    end;
end;


% Eingabe der Grenzfrequenz der Fourierreihe [Hz]
disp('2. Eingabe der Abbruch(Grenz-)frequenz der Fourierreihe : ');
m_Grenz = input('Index m mit Grenzfrequenz = m * Grundfrequenz (max. Index m = N/2-1) : ');

% Automatische Bestimmung der Anzahl an Abtastwerten bzw. Spektrallinien N
% aus Dimension des Vektors X 
Dimension = size(X_m);
N = Dimension(1);         % Beachte: Spiegelspektrum der FFT muss berücksichtigt werden

% Schnelle inverse Fouriertransformation IFFT
% x_ifft = ifft(X_m);     % Aufruf der Matlab-Funktion ifft.m 
                          % mit Übergabe des komplexen Spektrums X
% x_ifft = x_ifft*N;      % Normierung auf korrekte Amplitude nach IFFT-Algorithmus

% Analytische Fourierreihe mit pos. und neg. Frequenzen
f0 = f(2)-f(1);          % Grundfrequenz der Fourierreihe von Workspace
TA = 1/(N*f0);           % Berechnung der Abtastperiode über Abstand der Spektrallinien
t = linspace(0,(N-1)*TA,N)';
x_ifft = zeros(1,N)';
% Addition der harmonischen Zeitsignale
for m = 2:m_Grenz+1         % Grundspektrum um f=0
    x_ifft = x_ifft + X_m(m)*exp(j*2*pi*(m-1)*f0*t);
end;
for m = N-m_Grenz+1:N       % Spiegelspektrum um f=fA (Abtastfrequenz)
   x_ifft = x_ifft + X_m(m)*exp(j*2*pi*(m-1-N)*f0*t);
end;
x_ifft = X_m(1) + x_ifft;     % Addition des Gleichanteils

% Graphische Ausgabe als 2D-Plot
% abhängig von Art der Datenquelle (mit oder ohne Vergleich)
figure();
switch Datenquelle
        case 'd'
            % Bei Einlesen einer ASCII-Datei von Laufwerk/Festplatte
            plot (t,x_ifft,'r')             % Darstellung als Funktion
            title('Zeitbereichsfunktion');  % Diagramm-Überschrift
            legend ('IFFT-transformiert');  % Legende
            xlabel('Zeit t [s]');           % x-Achsenbeschriftung
            ylabel('Zeitsignal [1]');       % y-Achsenbeschriftung
            grid on;                        % Einblendung des Grids
            axis ('auto');
            figure();
            stairs(t,x_ifft,'g.-')          % Darstellung als Schrittfunktion
            title('IFFT-transformiert (Schrittfunktion)'); % Diagramm-Überschrift
            xlabel('Zeit t [s]');           % x-Achsenbeschriftung
            ylabel('Zeitsignal [1]');       % y-Achsenbeschriftung
            grid on;                        % Einblendung des Grids
            axis ('auto');
        case 'w'
            % Bei Einlesen des komplexen Spektrums über das Command Window 
            % und gleichzeitigem Vergleich mit Original-Zeitfunktion
            % über die Vektoren "time" und "data"
            plot (time,data,'g-',t,x_ifft,'r')           % Darstellung als Funktion
            title('Zeitbereichsfunktionen');             % Diagramm-Überschrift
            legend ('Original','IFFT-transformiert');    % Legende
            xlabel('Zeit t [s]');           % x-Achsenbeschriftung
            ylabel('Zeitsignal [1]');       % y-Achsenbeschriftung
            grid on;                        % Einblendung des Grids
            axis ('auto');
            figure();
            stairs(t,x_ifft,'g.-')          % Darstellung als Schrittfunktion
            title('IFFT-transformiert (Schrittfunktion)'); % Diagramm-Überschrift
            xlabel('Zeit t [s]');           % x-Achsenbeschriftung
            ylabel('Zeitsignal [1]');       % y-Achsenbeschriftung
            grid on;                        % Einblendung des Grids
            axis ('auto');
end;