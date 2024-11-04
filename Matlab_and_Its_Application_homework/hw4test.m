A=[20.0000         0;
   18.6800    5.7784;
   15.0651   10.3066;
   10.0801   12.7025;
    4.9366   12.6977;
    0.7574   10.6805;
   -1.7558    7.5259;
   -2.4998    4.2742;
   -1.9364    1.7738;
   -0.8673    0.4100;
   -0.0991    0.0141;
   -0.1236   -0.0198;
   -0.9258   -0.4569;
   -1.9895   -1.8849;
   -2.4991   -4.4428;
   -1.6636   -7.7147;
    0.9516  -10.8333;
    5.2084  -12.7575;
   10.3753  -12.6323;
   15.3146  -10.1035;
   18.8210   -5.4770;
   19.9958    0.3363];
X=A(:,1);
Y=A(:,2);
[theta,rho]=cart2pol(X,Y);
pp=spline(theta,rho);
t=linspace(-pi,pi,100);
polarplot(t,ppval(pp,t))
hold on
polarscatter(theta,rho)
hold off
dpp=fnder(pp,1);

curve=@(t)sqrt(ppval(pp,t).^2+ppval(dpp,t).^2);
curve_length=integral(curve,-pi,pi);
fprintf('曲线长度为 %.3f',curve_length)