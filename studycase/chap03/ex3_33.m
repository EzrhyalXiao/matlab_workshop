clear all;
A=[1 3 0;3 1 0;9 2 4];
B=sum(A)					%矩阵中元素按照列进行求和
C=sum(A,2)				%矩阵中元素按照行进行求和
D=cumsum(A)				%矩阵中各列元素的和
E=cumsum(A,2)			%矩阵中各行元素的和
F=sum(sum(A))			%矩阵中所有元素的和
