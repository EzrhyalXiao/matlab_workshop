f=@(x) sin(x)/sqrt(1-x^2);
re1=integral(f,0,1,'ArrayValued',true);

f2=@(x,y) 1+2*x+y+x.*y;
ymax=@(x) 1+sqrt(1-x.^2);
ymin=@(x) 1-sqrt(1-x.^2);
re2=integral2(f2,-1,1,ymin,ymax);

