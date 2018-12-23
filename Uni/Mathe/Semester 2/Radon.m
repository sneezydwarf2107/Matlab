N = 101;
I = phantom(N);
subplot(1, 3, 1)
imshow(I)

theta = 0:1:179;
[R, xp] = radon(I,theta);
subplot(1,3,2);
imshow(R,[],'Xdata',theta,'Ydata',xp,...
            'InitialMagnification','fit')
colormap(gca, hot), colorbar
iptsetpref('ImshowAxesVisible','off')
R1 = zeros(145,180);


for w= 1:180 %Verdrehung des Winkels von 1 - 180�
    for i=-50:1:50 %y Koordinaten des durchdringenden Vektors
        for j=-50:1:50 %x-Koordinaten des durchdringenden Vektors
            n=i+51; %Anpassen der y-Koordinate auf das Bild I 
            m = abs(j- 51); %Anpassen der y-Koordinate auf das Bild I 
          s = round(i*cos(w*pi/180)+j*sin(w*pi/180)); %Verdrehen des Vektors i,j um den Winkel w 
          R1(s+72, w) = R1(s+72, w)+I(m,n); %Aufsummieren der Funktionswerte (Farbwert des Bildes I) an der Stelle m,n entlang des Vektors i,j in der Matrix R1
        end
    end
end
subplot(1, 3, 3)
imshow(R1,[],'Xdata',theta,'Ydata',xp,...
            'InitialMagnification','fit')
% xlabel('\theta (degrees)')
% ylabel('x''')
colormap(gca, hot), colorbar
iptsetpref('ImshowAxesVisible','off')
