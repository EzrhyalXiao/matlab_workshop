clear
x= -1:0.01:1;	%  生成自变量
g=[1 3 5 7 9];	%  函数对应的多项式
h=polyval(g,x);	%  进行估值运算
plot(x , h);xlabel('x');title('x^4+3x^3+5x^2+7x+9');	%将估值运算结果对自变量作图
