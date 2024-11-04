clear all;
x=0:2*pi;
y=sin(x)
z=interpft(y,15);
xx=linspace(0,2*pi,15);%生成0～2pi之间的15个线性等分点
plot(x,y,'-o',xx,z,':o')
