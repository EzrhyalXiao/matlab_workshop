m=4;
n=30;
[x,y]=meshgrid(-m:m/n:m,-m:m/n:m);
u=1./sqrt(1+sin(x.^2+y.^2).^2);
v=sin(x.^2+y.^2)./sqrt(1+sin(x.^2+y.^2).^2);
quiver(x,y,u,v,1)
xlabel('x');
ylabel('y');
title('Line field of dy/dx = sin(x^2 + y^2)');
