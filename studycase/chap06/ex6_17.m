%一维快速傅里叶插值实现数据增采样
clear all;
x = 0:1.2:10;
y = sin(x);
n = 2*length(x);		%增采样1 倍
yi = interpft(y,n);	%一维快速傅里叶插值
xi = 0:0.6:10.4;
hold on;
plot(x,y,'ro');		%画图
plot(xi,yi,'b.-');
title('一维快速傅里叶插值');
legend('原始数据','插值结果');
