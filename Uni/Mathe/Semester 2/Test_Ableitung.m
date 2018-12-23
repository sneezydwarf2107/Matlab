N=1000;
x=-7:0.0001:7;
y=(x.^2);
plot(x,y)
hold
grid on


a = zeros(N,1);

for k=1:N-1
    a(k) = (y(k+1)-y(k))/(x(k+1)-x(k));
end
plot(x,a)
axis([-7 7 -7 7])