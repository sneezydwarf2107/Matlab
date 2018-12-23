% Definition Zeitsignal zum Import in Simulink

% Zeitvektor
t = 0:1e-3:1;

% Wertevektor
x1 = sin(2*pi*2*t);

% Uebergabe an Simulink muss mit Spaltenvektoren erfolgen!
X1 = [t',x1'];
