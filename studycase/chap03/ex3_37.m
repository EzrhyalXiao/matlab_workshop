clear all
a=[1 2 3;3 4 5;7 8 9];
b=norm(a,1);  			%矩阵的1阶范式
c=norm(a) ;    			%矩阵的2阶范式
d=norm(a,inf) ; 			%矩阵的无穷范式
e=norm(a,'fro');  		%矩阵的Frobenius范式
f=normest(a);  			%矩阵的2阶范式的估计值
bcdef=[ b c d e f ]
