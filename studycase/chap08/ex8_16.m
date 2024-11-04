x = 1:10;
y = x + randn(1,10);
scatter(x,y,25,'b','*')
lsline
mu = mean(y);
hline = refline([0 mu]);
set(hline,'Color','r')
