p = [1 -2 -1 0];
t = 0:0.1:3;
y = polyval(p,t) + 0.5*randn(size(t));
plot(t,y,'ro')
h = refcurve(p);
set(h,'Color','r')
q = polyfit(t,y,3);
refcurve(q)
legend('Data','Population Mean','Fitted Mean', 'Location','NW')
