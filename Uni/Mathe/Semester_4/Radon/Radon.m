function [] = Radon()

N = phantom(101);
theta = 0:1:180;
[R, xp] = radon(N,theta);
subplot(1,3,2);
imshow(R,[],'Xdata',theta,'Ydata',xp,...
            'InitialMagnification','fit')
colormap(gca, hot);

for w=1:180
    for y=1:101
        for x=1:101
          
end

