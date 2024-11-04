t = (1:10)'; 
randn('state',0);
x = randn(size(t)); 
ts = linspace(-5,15,600)'; 
y = sinc(ts(:,ones(size(t))) - t(:,ones(size(ts)))')*x;
plot(t,x,'o',ts,y)
