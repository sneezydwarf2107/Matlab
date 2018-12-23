%% M-Dateiname: "Systemidentifikation_FFT.m"
% Löschen des Command Window
clc;

%% Messsignal
%time = in_signal.time(:,1);
%data = in_signal.signals.values(:,1);
time = out_signal.time(:,1);
data = out_signal.signals.values(:,1);

%% Anzahl der Abtastwerte der FFT einstellen
N=2^18;

%% Lineare Interpolation der eingelesenen Messwerte
% im äquidistanten Zeitraster mit Abtastperiode TA=1/fA
% Ermittlung der Anzahl an Messwerten (Datenzeilen)
Dimension = size(time);
Anzahl_Messwerte = Dimension(1);

% Zeitausschnitt festlegen und Vektor neu erzeugen
t_intervall = [0,0];
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
figure(2);
subplot (2,1,1,'XScale','log','YScale','log')            % Darstellung des Betragsspektrums
   hold on;
   stem(f,X_Betrag,'r.-') % Darstellung der Funktion mit formatierten Linien
   title(['Frequenzbereich - Linienspektrum mit N='...
          ,num2str(N)]); % Diagramm-Überschrift
   xlabel('Frequenz f [Hz]');      % x-Achsenbeschriftung
   ylabel('Betrag X0,2*|X_m|');    % y-Achsenbeschriftung
   grid on;                        % Einblendung des Grids
   legend('-DynamicLegend');
   legend(gca,'show');
   axis ('auto');                  % Automatische Achsenskalierung 
   
subplot (2,1,2,'XScale','log')     % Darstellung des Phasenspektrums
   hold on;
   stem(f,X_Phase,'r.-')  % Darstellung der Funktion mit formatierten Linien
   xlabel('Frequenz f [Hz]');      % x-Achsenbeschriftung
   ylabel('Phase phi_m [rad]');    % y-Achsenbeschriftung
   grid on;                        % Einblendung des Grids
   legend('-DynamicLegend');
   legend(gca,'show');
   axis ('auto');                  % Automatische Achsenskalierung