clear
M=10;
x = 0:.01:2*pi;

for n=1:M
    subplot(M/2,2,n)
    plot(x,sin(n*x));
    axis([0 2*pi -1.2 1.2])
    grid on
    end
