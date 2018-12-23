%% M-Dateiname: "FFT_PSD_Analyse.m"
% Schnelle Fouriertransformation FFT (Fourieranalyse)
% Mess-Signal mit Zeit- und Messwertpalte
% Spaltenvektoren:  time  und  data
% von einer Datei oder über Workspace u.a. von Simulink eingelesen
% Anmerkung:  Fourieranalyse erfolgt mit der reellen Darstellung
% x(t) = X0 + 2*Summe(|X_m|*cos(2*pi*m*f0*t+phi_m))  mit m=1,2,....,inf
% Beachte:  Zeitfunktion ist für t>=0 zu definieren
% Autor: J. Baur
% Datum: 01.07.2017
% Löschen des Command Window
clc;

%% Eingabe der Datenquelle für Messwerte
Datenquelle = ' ';
disp('1. Festlegung der Datenquelle mit 2 Spalten ==> (Zeit Wert)');
while (Datenquelle~='d')&(Datenquelle~='s')&(Datenquelle~='w')
    Datenquelle = input('Wählen Sie Datei [d], Simulink [s] oder Workspace [w]: ','s');
    switch Datenquelle
        case 'd'
            % Einlesen einer ASCII-Datei von Laufwerk/Festplatte
            disp('Eingabe des Dateinamens mit Pfad (aktueller Ordner mit .\)');
            Dateiname = input('Dateiname : ','s');
            % Einlesen in den Vektoren: Zeiten und Messwerte
            Daten_in = dlmread(Dateiname,' ',0,0);
            time = Daten_in(:,1);
            data = Daten_in(:,2);
         case 's'
            % Einlesen von Workspace über Struktur "Messung" von Simulink
            % Wichtig:  In Simulink Variablenname "Messung" festlegen
            % und Format "Structure With Time" 
            % in Block "To WORKSPACE" anwählen
            time = Messung.time(:,1);
            data = Messung.signals.values(:,1);
         case 'w'
            % Einlesen der im Command Window definierten Spaltenvektoren: 
            % "Zeiten" und "Messwerte"
            disp('Direkte Übernahme der beiden Spaltenvektoren "time(n)" und "data(n)"');
         otherwise
            disp('Falsche Eingabe!');
    end;
end;

%% Anzahl der Abtastwerte der FFT einstellen
% N=2^i Abtastwerte (1,2,4,8,16,32,64,128,256,512,1024,2048,4096,...)
% Beachte: Nyquisttheorem Abtastfrequenz > 2*Grenzfrequenz des Signals
disp('2. Abtastfrequenz der FFT einstellen');
N = input('Anzahl der Abtastwerte N = 2^i : ');

%% Lineare Interpolation der eingelesenen Messwerte
% im äquidistanten Zeitraster mit Abtastperiode TA=1/fA
% Ermittlung der Anzahl an Messwerten (Datenzeilen)
Dimension = size(time);
Anzahl_Messwerte = Dimension(1);
%% Zeitausschnitt erwünscht oder komplette Daten
disp('3. Zeitausschnitt des Signals festlegen');
% Plot der eingelesenen Daten
figure(1);
plot(time,data,'r-');
title('Eingelesene Messwerte');
xlabel('Zeit t [s]');           % x-Achsenbeschriftung
ylabel('Mess-Signal x(t)');     % y-Achsenbeschriftung
grid on;
% Zeitausschnitt festlegen und Vektor neu erzeugen
t_intervall = input('[tmin,tmax] oder [0,0]:  ');
tmin = t_intervall(1);
tmax = t_intervall(2);
if t_intervall ~= [0 0]
    for n = 1:Anzahl_Messwerte
        if time(n) <= tmin
            n_low = n;
        else
            if time(n) <= tmax
                n_high = n;
            end
        end
    end
    % Korrektur der Anzahl Messwerte
    Anzahl_Messwerte = n_high - n_low + 1;
    % Korrektur des Zeit- und Wertevektors auf NEU
    time_new = 0;
    data_new = 0;
    for n = 1:Anzahl_Messwerte
        time_new(n) = time(n_low+n-1);
        data_new(n) = data(n_low+n-1);
    end
else
    time_new = time;             % Zeitvektor für interne Verarbeitung
    data_new = data;             % Wertevektor für interne Verarbeitung
end
    
%% Berechnung der zu den Abtastzeitpunkten interpolierten Messwerten 
% (diese sind neu berechnet) 
% Ermittlung der Abtastperiode
TA = (time_new(Anzahl_Messwerte)-time_new(1)) / (N-1);
% Ermittlung des Spaltenvektors der äquidistanten Abtastzeitpunkte für FFT
time_FFT = linspace(time_new(1),time_new(Anzahl_Messwerte),N)';
data_FFT = zeros(N,1);
% Berechnen aller N approximierten Messwerten
for n=1:1:N
    % Bestimmung des Zeitpunktes ==> time(k)
    % kurz vor dem aktuellen Abtastzeitpunkt ==> time_FFT(n)
    k = 2;          % Initialisierung des Suchindex k für Vektor Messwerte
    while (time_new(k) < time_FFT(n)) & (k<=Anzahl_Messwerte)
        k=k+1;
    end;
    % Festlegung des approximierten Abtastwertes ==> Messwerte_FFT(n)
    Steigung = (data_new(k)-data_new(k-1)) / (time_new(k)-time_new(k-1));
    % bei Unstetigkeiten im Signal
    switch Steigung
        case -inf 
            Steigung=1e9;
        case inf
            Steigung=-1e9;
    end
    data_FFT(n) = data_new(k-1) + Steigung*(time_FFT(n)-time_new(k-1));
end;

%% Vergleich der eingelesenen und der approximierten Messwerten
% Erzeugen eines neuen Plot-Fensters bei jedem plot-Aufruf
figure(2);
plot(time_new,data_new,'b.',time_FFT,data_FFT,'r-');
legend ('Eingelesene Messwerte','Approximierte Messwerte');
% Sichtbarer Bereich der Achsen mit:  axis([tmin tmax tmin tmax])
title('Eingelesene und approximierte Messwerte');
xlabel('Zeit t [s]');           % x-Achsenbeschriftung
ylabel('Mess-Signal x(t)');     % y-Achsenbeschriftung
grid on;
axis ('auto'); 

%% Plot des Zeitsignals mit N Abtastwerten
% der Abtastperiode TA mit Abtasthalteglied
figure(3);
stairs(time_FFT,data_FFT,'b');
legend (['Zeitsignal fuer FFT-Analyse mit N=',num2str(N)]);      % Legende
title('Abgetastete approximierte Messwerte'); % Diagramm-Überschrift
xlabel('Zeit t [s]');           % x-Achsenbeschriftung
ylabel('Mess-Signal x(t)');     % y-Achsenbeschriftung
grid on;                        % Einblendung des Grids
axis ('auto');                  % Automatische Achsenskalierung

%% Schnelle Fouriertransformation FFT
X_m = fft(data_FFT);      % Aufruf der Matlab-Funktion fft.m 
                          % mit Übergabe der approximierten Messwerte
X_m = X_m/N;              % Normierung auf korrekte Amplitude nach FFT-Algorithmus

% Darstellung mit positiven Frequenzen f=0 ... (N/2-1)/N * fA
% Komplexes Spektrum Spektrum = X(jf)
Spektrum = [X_m(1) ; X_m(2:N/2)];       
% Frequenzvektor für 2D-Plot nach Betrag und Phase
f = ([0:N/2-1] / ((N-1)*TA))';
X_Betrag = [abs(Spektrum(1)) ; 2*abs(Spektrum(2:N/2))];   % Betragsfunktion
if Spektrum(1) > 0
    X_Phase  = [0 ; angle(Spektrum(2:N/2))];             % Phasenfunktion für pos. Gleichanteil
else
    X_Phase  = [-pi ; angle(Spektrum(2:N/2))];           % Phasenfunktion für neg. Gleichanteil
end;
% Format subplot(Anzahl Zeilen,Anzahl Spalten,Fensternummer)
figure(4);
subplot (2,1,1)            % Darstellung des Betragsspektrums
   hold on;
   stem(f,X_Betrag,'r.-') % Darstellung der Funktion mit formatierten Linien
   title(['Frequenzbereich - Linienspektrum mit N='...
          ,num2str(N)]); % Diagramm-Überschrift
   xlabel('Frequenz f [Hz]');      % x-Achsenbeschriftung
   ylabel('Betrag X0,2*|X_m|');    % y-Achsenbeschriftung
   grid on;                        % Einblendung des Grids
   axis ('auto');                  % Automatische Achsenskalierung 
   
subplot (2,1,2)            % Darstellung des Phasenspektrums
   hold on;
   stem(f,X_Phase,'r.-')  % Darstellung der Funktion mit formatierten Linien
   xlabel('Frequenz f [Hz]');      % x-Achsenbeschriftung
   ylabel('Phase phi_m [rad]');    % y-Achsenbeschriftung
   grid on;                        % Einblendung des Grids
   axis ('auto');                  % Automatische Achsenskalierung

%% PSD-Analyse (power-spectral-density)
% Leistungsdichte-Spektrum [dB/Hz] bzw. [W/Hz]
% 3dB = Faktor 2, 10dB = Faktor 10, 20dB = Faktor 100
% Matlab-Funktion pwelch (wahlweise mit Fensterung)
% Pxx = Autoleistungsdichtespektrum (Schätzwert)
% Fxx = Frequenzvektor
% N/2 = Länge einer Sequenz (<=N)
[Pxx,Fxx] = pwelch(data_FFT,[],[],N/2,1/TA);
figure(5);
plot(Fxx,10*log10(Pxx));
hold on;
axis auto;
%axis([0 1000 -60 0]);
title('Leistungsdichtespektrum');
xlabel('Frequenz [Hz]');
ylabel('Leistungsdichtespektrum [db/Hz]');
grid on;