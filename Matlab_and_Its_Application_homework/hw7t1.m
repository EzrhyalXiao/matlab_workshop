A=randn(12,12);
b=randn(12,1);
[V,D]=eig(A);
condi=cond(A);
[U,S,V2]=svd(A);
[L,U2]=lu(A);
if rank(A)==12
    x=A\b;
else
    y=(A.'*A)\(A.'*b);
end