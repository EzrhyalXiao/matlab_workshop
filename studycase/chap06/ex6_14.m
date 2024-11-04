num=[ 5 3 -2 7];		%分子多项式
den=[-4 0 8 3];		%分母多项式
[r, p, k] = residue(num,den);
[n, d] = residue(r, p, k)
