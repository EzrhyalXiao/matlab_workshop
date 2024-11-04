A=[   470   300    10;
   285    80    10;
   470   300   120;
   470    80   120;
   470    80    10;
   100   190    10;
   100    80    65;
   470   190    65;
   100   300    54;
   100   300   120;
   100    80   120;
   285   300    10;
   285   190   120	];
rate=[8.5500
    3.7900
    4.8200
    0.0200
    2.7500
   14.3900
    2.5400
    4.3500
   13.0000
    8.5000
    0.0500
   11.3200
    3.1300];
x1=A(:,1);
x2=A(:,2);
x3=A(:,3);
beta0=[0,0,0,0,0];
rate_fit=@(beta, A)(beta(1)*x2+beta(2)*x3)./(1+beta(3)*x1+beta(4)*x2+beta(5)*x3);
options=optimset('MaxIter',500);
[beta,resnorm]=lsqcurvefit(rate_fit,beta0,[x1 x2 x3],rate,[],[],options);

plot(1:length(rate),rate)
hold on
plot(1:length(rate),rate_fit(beta))
legend('rate','fitted')