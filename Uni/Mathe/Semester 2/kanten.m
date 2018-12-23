clear all;
A= double(imread('rice.png'));
[n,m]= size(A);
Delta = 0.5;


for i=1:n-1
    for j=1:m-1
    
        g(i,j) = sqrt(((A(i+1,j)-A(i,j))/Delta)^2+((A(i,j+1)-A(i,j))/Delta)^2);
    
    end
    
    
end

subplot(1,2,1)
imshow(uint8(A));
subplot(1,2,2)
imshow(uint8(g))
