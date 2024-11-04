clear all
clc
x=[0.3 0.4 0.7 0.9 1.2 1.9 2.8 3.2 3.7 4.5];
y=[1 2 3 4 5 2 6 9 2 7];
p5=polyfit(x,y,5);				%5阶多项式拟合
y5=polyval(p5,x);
p5=vpa(poly2sym(p5),5)			%显示5阶多项式
p9=polyfit(x,y,9);				%9阶多项式拟合
y9=polyval(p9,x);	
figure;						%画图显示
plot(x,y,'bo');
hold on;
plot(x,y5,'r:');
plot(x,y9,'g--');
legend('原始数据','5阶多项式拟合','9阶多项式拟合');
xlabel('x');
ylabel('y');
