clear all 
clc
x1=[59.6 55.2 56.6 55.8 60.2 57.4 59.8 56.0 55.8 57.4];
x2=[56.8 54.4 59.0 57.0 56.0 60.0 58.2 59.6 59.2 53.8];
x=[x1 x2]';
muhat=mean(x)
sigma2hat=moment(x,2)
var(x,1)
