clear all;
[X,Y] = meshgrid(-3:.25:3);  %产生已知道德数据栅格点
Z = peaks(X,Y);         %计算已知点的函数值
[XI,YI] = meshgrid(-3:.125:3);   %产生更精密的插值点
ZI = interp2(X,Y,Z,XI,YI);     
mesh(X,Y,Z), hold, mesh(XI,YI,ZI+15)
hold off
axis([-3 3 -3 3 -5 20])
