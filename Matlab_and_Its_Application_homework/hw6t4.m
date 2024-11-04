syms m n 
n1=(1-m)*(1-n)/4;
n2=(1+m)*(1-n)/4;
n3=(1+m)*(1+n)/4;
n4=(1-m)*(1+n)/4;
fx=1*n1+4*n2+5*n3+2*n4;
fy=2*n1+3*n2+5*n3+6*n4;

J=abs(det(jacobian([fx,fy],[m,n])));


[x,y]=meshgrid([-sqrt(3)/3 sqrt(3)/3],[-sqrt(3)/3 sqrt(3)/3]);

X=eval(subs(fx,{m,n},{x,y}));
Y=eval(subs(fy,{m,n},{x,y}));
f=@(x,y) (x.^2+y.^2).*sin(x+y);
re4=sum(sum(f(X,Y).*eval(subs(J,{m,n},{x,y}))));



