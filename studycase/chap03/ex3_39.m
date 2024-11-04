clear all
A=[1 2 3;3 4 5;7 8 9];
B=magic(5);
r1=det(A);				%矩阵的行列式
r2=det(B);
disp(['a的行列式值=',num2str(r1)]);
disp(['b的行列式值=',num2str(r2)]);
