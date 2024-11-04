p1 = pdf('Normal',-2:2,0,1)
p2 = pdf('Poisson',0:4,1:5)
MU = [1 2;-3 -5];
SIGMA = cat(3,[2 0;0 .5],[1 0;0 1]);
p = ones(1,2)/2;
obj = gmdistribution(MU,SIGMA,p)
ezsurf(@(x,y)pdf(obj,[x y]),[-10 10],[-10 10])
RAND=randn(1000,1);
fx=sin((1:1000)*pi/500);
[f,xi]=ksdensity(RAND+5*fx');
figure;
plot(xi,f);
axis tight
