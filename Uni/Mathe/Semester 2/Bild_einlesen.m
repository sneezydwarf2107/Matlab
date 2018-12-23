A = imread('rice.png');
z = 128;
B=A;

subplot(1,3,1);
imshow(A);

subplot(1,3,2);
plot(A(z,:));

B(z,:) = 255;
subplot(1,3,3);
imshow(B);