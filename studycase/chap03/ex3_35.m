clear all;
A= magic(3);
B=diff(A)			%矩阵各列元素的差分
C=diff(A,2)			%矩阵各列元素的2阶差分
D=diff(A,1,1)		%矩阵各列元素的差分
E=diff(A,1,2)		%矩阵各行元素的差分
