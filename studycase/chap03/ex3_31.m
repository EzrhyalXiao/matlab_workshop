clear all;
A=[1 3 0;3 1 0;9 2 4];
B=sort(A);				%矩阵中元素按照列进行升序排序
C=sort(A,2); 				%矩阵中元素按照行进行升序排序
D=sort(A,'descend');		%矩阵中元素按照列进行降序排序
E=sort(A,2,'descend');	%矩阵中元素按照行进行降序排序
BCDE=[B C;D E]
