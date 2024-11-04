c1=20;
n=10;
options=optimoptions('particleswarm','SwarmSize',100*n,'MaxIterations',2500,'plotFcn','pswplotbestf','MaxStallTime',1000);


f=@(x)-c1*exp(-0.2*sqrt(sum(x.^2)/length(x)))-exp(sum(cos(2*pi*x))/length(x));

sol=particleswarm(f,n,[],[],options);

g=@(x,y) -exp((cos(2*pi*x)+cos(2*pi*y))/2)-c1*exp(-0.2*sqrt((x.^2+y.^2)/2));
m=10;
[X,Y]=meshgrid(-m:0.1:m,-m:0.1:m);
Z=g(X,Y);
%mesh(X,Y,Z)

disp(sol)