clear all
clc
x1=[59.6 55.2 56.6 55.8 60.2 57.4 59.8 56.0 55.8 57.4];
x2=[56.8 54.4 59.0 57.0 56.0 60.0 58.2 59.6 59.2 53.8];
x=[x1 x2]';
a=0.05;
[muhat,sigmahat,muci,sigmaci]=normfit(x,a);
[p,ci]=mle('norm',x,a);
n=numel(x);
format long
muhat
p1=p(1)
sigmahat
sigmahat1=var(x).^0.5
p2=p(2)
muci
ci
sigmaci
muci1=[muhat-tinv(1-a/2,n-1)*sigmahat/sqrt(n),muhat+tinv(1-a/2,n-1)*sigmahat/sqrt(n)]
sigmaci1=[((n-1).*sigmahat.^2/chi2inv(1-a/2,n-1)).^0.5,((n-1).*sigmahat.^2/chi2inv(a/2,n-1)).^0.5]

