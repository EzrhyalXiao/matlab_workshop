[theta,r]=meshgrid(0:2*pi/100:2*pi,0:0.01:1);
[X,Y]=pol2cart(theta,r);
x=7*X;
y=6*Y;

n=1000;
for i=0:10/n:10
z=exp(1-i).*sqrt(x.^2+y.^2);
surf(x,y,z);
axis([-7 7 -6 6 0 1]);
title(sprintf('t = %.2f',i)); 
pause(10/n); 
end