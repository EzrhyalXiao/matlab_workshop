Schaffer=@(x,y)0.5+(sin(sqrt(x.^2+y.^2))^2-0.5)./(1+0.001*(x.^2+y.^2))^2 ;
%options=optimset('PlotFcns',@optimplotfval,'Tolfun',1.0e-8,'Tolx',1.0e-8);
%[x,fval,exitflag,output]=fminsearch(Schaffer,1,options);
n=20;
[X,Y]=meshgrid(-n:0.1:n,-n:0.1:n);
Z=Schaffer(X,Y);
contour(X,Y,Z, 35)


xx=[5.764 6.286 6.759 7.168 7.480];
yy=[0.648 1.202 1.823 2.526 3.360];
f=@(x) sum((x(1)*xx.^2+x(2)*xx.*yy+x(3)*yy.^2+x(4)*xx+x(5)*yy+x(6)).^2);
[ellip,val]=fmincon(f,[1,1,1,0,0,1],[],[],[],[],[],[],@my_con);

f_forecast=@(x,y) ellip(1)*x^2+ellip(2)*x*y+ellip(3)*y^2+ellip(4)*x+ellip(5)*y+ellip(6);
ezplot(f_forecast);
hold on
scatter([5.764 6.286 6.759 7.168 7.480],[0.648 1.202 1.823 2.526 3.360]);
hold off
function[c,ceq]=my_con(x)
c=[];
ceq=4*x(1)*x(3)-x(2)^2-1;
end

