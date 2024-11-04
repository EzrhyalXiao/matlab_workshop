
n=64;
a=0;
b=1;
c=0;
d=1;
type=2;
dx=(b-a)/n;
dy=(d-c)/n;
tol=1.e-5;
k=0;


%max(max(abs(z0-z)))
m=1;
klist=m;
for i=1:m
    w=0.05*(i-1)+1;
    [U1,k]=SOR_sol(a,b,c,d,n,w,tol,type);
    klist(i)=k;
end

%plot(klist)
[x,y]=meshgrid(a:dx:b,c:dy:d);
z=zeros(n+1,n+1);
for i=1:(n+1)
    for j=1:(n+1)
        z(i,j)=U1((i-1)*(n+2)+j);
    end
end
mesh(x, y, z);


function [U1,k]=SOR_sol(a,b,c,d,n,w,tol,type)
U1=rand((n+1)*(n+2),1);
err=1;
k=0;
while err>tol
    U2=SOR(a,b,c,d,n,U1,w,type);
    err=max(max(abs(U2-U1)));
    U1=U2;
    k=k+1;
end
end

function[U2]=SOR(a,b,c,d,n,U1,w,type)
dx=(b-a)/n;
dy=(d-c)/n;
U2=U1;
for i=1:(n+1)*(n+2)
    xi=(mod(i,n+2)-1)*dx+a;
    yi=c+(ceil(i/(n+2))-1)*dy;
    if mod(i,n+2)==0
        U2(i)=2*dx*(deri_f(yi,type))+U2(i-2);
    elseif i<= n+2 || i>n*(n+2)
        U2(i)=f_3(xi,yi,type,n);
    elseif mod(i,n+2)~=1
        U2(i)=(f_3(xi,yi,type,n)-1/dx^2*U1(i+1)-1/dx^2*U2(i-1)-p(xi,yi,type)/dy^2*U1(i+n+2)-p(xi,yi,type)/dy^2*U2(i-n-2))/(-2/dx^2-2*p(xi,yi,type)/dy^2+r(xi,yi,type));
    else
        U2(i)=f_3(xi,yi,type,n);
    end
end
U2=w*U2+(1-w)*U1;
end


function[fun]=p(x,y,type)
if type==1
    fun=1+x.^2+y.^2;
else
    fun=1;
end
end

function[fun]=r(x,y,type)
if type==1
    fun=-x.*y;
else
    fun=0;
end
end

function[fun]=f_3(x,y,type,n)%由于f函数名与前文冲突，改用f_3
    if type==1
        fun=-(pi^2*(2+x.^2+y.^2)+x.*y).*sin(pi*x).*sin(pi*y);
    else
        if x==0.5 && y==0.5
            fun=-n^2;
        else
            fun=0;
        end
    end
end


function[fun]=deri_f(y,type)%边界条件
    if type==1
        fun=-pi*sin(pi*y);
    else
        fun=-1;   
    end
end