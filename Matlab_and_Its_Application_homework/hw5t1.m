rou1=1/4;
rou2=3;
N1=1000;
N2=5000;
r1=1;r2=0.2;
h=0.1;
x_0=[N1/2 N2/2];
x_next=@(x) [x(1)+h*r1*x(1)*(1-x(1)/N1+rou1*x(2)/N2) x(2)+h*r2*x(2)*(-1-x(2)/N2+rou2*x(1)/N1)] ;
b=5;
time=0:h:b;
x=x_next(x_0);
xs=[x_0;x ;zeros(b/h-1,2)];
for i=3:b/h+1
    x=x_next(x);
    xs(i,:)=x;
end
plot(time,xs)
hold on

f=@(t,x) [r1*x(1)*(1-x(1)/N1+rou1*x(2)/N2);r2*x(2)*(-1-x(2)/N2+rou2*x(1)/N1)] ;
[time2,x_lk]=ode45(f,[0,b],x_0.');
plot(time2,x_lk)
legend('物种1','物种2','物种1(lk)','物种2(lk)')
hold off