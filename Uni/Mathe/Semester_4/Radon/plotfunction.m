function [] = plotfunction()
ug = -2*pi;
og = 2*pi;
n = 0.001;

x = ug:n:og;
y=sin(x);

plot(x,y);
grid on;
hold on;

a = (sin(x+n)-sin(x))/n;

plot(x,a);
end

