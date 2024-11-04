clear all
A=pascal(5);
[U,S]=schur(A)
U*S*U'-A  		%—È÷§
