clear all;
x=0:2*pi;
y=sin(x)
xx=0:0.5:2*pi;
yy=interp1(x,y,xx);
plot(x,y,'s',xx,yy)
