clear all;
f=@(x,y)y*sin(x)+3*cos(y)-1;
xmin=pi;
xmax=2*pi;
ymin=0;
ymax=pi;
q=dblquad(f,xmin,xmax,ymin,ymax)