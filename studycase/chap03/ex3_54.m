clear all
a=[0 0 0 1;0 0 8 0;4 0 0 0;0 0 0 0];
S=sparse(a); 		%创建稀疏矩阵
whos;
n1=nnz(S)  			%查看非零元素的个数
n2=nonzeros(S)   	%非零元素的值
n3=nzmax(S)      		%查看稀疏矩阵的存储空间
spy(S)
n4=nnz(S)/prod(size(S))
