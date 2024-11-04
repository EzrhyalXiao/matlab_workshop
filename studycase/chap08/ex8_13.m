x = 1:10;
y1 = x + randn(1,10);
scatter(x,y1,25,'b','*')
hold on
y2 = 2*x + randn(1,10);
plot(x,y2,'mo')
y3 = 3*x + randn(1,10);
plot(x,y3,'rx:')
y4 = 4*x + randn(1,10);
plot(x,y4,'g+--')
lsline
