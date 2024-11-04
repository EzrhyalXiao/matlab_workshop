clear all
clc
x=[-3:1:3]';
y=[1.1650  0.0751  -0.6965  0.0591 0.6268  0.3516  1.6961]';
[x,i]=sort(x);
y=y(i);
xi=min(x)+[0:100]/100*(max(x)-min(x));
for i=1:4
    N=2*i-1;
    [th,err,yi]=polyfits(x,y,N,xi);
    subplot(2,2,i)
    plot(x,y,'o')
    hold on
    plot(xi,yi,'-')
    grid on
end
