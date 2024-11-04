clear all
A=sprandsym(5,0.1)	%建立非零元素为随机数的对称稀疏矩阵
B=spones(a)         	%建立非零元素为1的与矩阵A维数相同的对称稀疏矩阵
C=full(A)    
D=full(B)
