clear all;
A=[2 4 5;8 9 6;1 3 5];
[L1,U1]=lu(A)   %矩阵的LU分解
[L2,U2,P]=lu(A)
Y1=lu(A)
L1*U1       %验证
Y2=L2+U2-eye(size(A)) %验证
