xx=[5.764 6.286 6.759 7.168 7.480];
yy=[0.648 1.202 1.823 2.526 3.360];
f=@(x) sum(((xx.*cos(x(5))-yy.*sin(x(5))-x(3)).^2/x(1)+(xx.*sin(x(5))+yy.*cos(x(5))-x(4)).^2/x(2)-1).^2);
[ellip,val]=fmincon(f,[1,1,0,0,0]);

theta=linspace(0,2*pi,100);
x=ellip(3)+sqrt(ellip(1))*cos(theta);
y=ellip(4)+sqrt(ellip(2))*sin(theta);
X=x*cos(ellip(5))+y*sin(ellip(5));
Y=-x*sin(ellip(5))+y*cos(ellip(5));
plot(X,Y)
hold on
scatter([5.764 6.286 6.759 7.168 7.480],[0.648 1.202 1.823 2.526 3.360]);
hold off

syms x y;
f=(x*cos(ellip(5))-y*sin(ellip(5))-ellip(3))^2/ellip(1)+(x*sin(ellip(5))+y*cos(ellip(5))-ellip(4))^2/ellip(2)-1;
f=expand (f);
disp(f)
fprintf('长轴长为：%4f \n',max(sqrt(ellip(1)),sqrt(ellip(2))))
fprintf('短轴长为：%4f \n',min(sqrt(ellip(1)),sqrt(ellip(2))))