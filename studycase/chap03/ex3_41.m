clear all
A=[1 2 3;3 4 5;7 8 9];
Z=null(A) %求矩阵A 的有理数形式的零矩阵
AZ=A*Z
ZR=null(A,'r')% 求矩阵A 的有理数形式的化零矩阵
AZR=A*ZR
