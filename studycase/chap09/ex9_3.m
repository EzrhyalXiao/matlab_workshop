clear all
clc
xdata = [3.6 7.7 9.3 4.1 8.6 2.8 1.3 7.9 10.0 5.4];
ydata = [16.5 150.6 263.1 24.7 208.5 9.9 2.7 163.9 325.0 54.3];
x0 = [10, 10, 10];    
[x,resnorm] = lsqcurvefit(@ex1024,x0,xdata,ydata)
