x = 0:0.05:50;
y = [1.5*cos(x);4*exp(-.1*x).*cos(x);exp(.05*x).*cos(x)]';
h = plot(x,y);	
delete(h(1:2:3))
