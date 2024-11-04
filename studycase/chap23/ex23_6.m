k=1;
k=1;
p=[-1:.05:8];
t=1+sin(k*pi/4*p);
plot(p,t,'-');
title('要逼近的非线性函数');
xlabel('时间');
ylabel('非线性函数');
