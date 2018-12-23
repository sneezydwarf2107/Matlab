%signal builder

%Sample frequency
fs = 44100;

%frequency in Hz
f = 100;

%song length in seconds
s = 5;

%Autoscaling the Plot to check the frequency 
s_plot = 1/f;

%filename.wav 
filename = 'test.wav';

x = linspace(0,2*pi*f*s,fs*s);
y = sin(x);
audiowrite(filename,y,fs);

plot(x/(2*pi*f),y);
axis([0 s_plot -inf inf]);