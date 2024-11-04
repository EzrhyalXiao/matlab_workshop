n=32;
a=0;
b=1;
c=0;
d=1;
dx=(b-a)/n;
dy=(d-c)/n;


A=zeros((n+1)*(n+2),(n+1)*(n+2));
for i=1:(n+1)*(n+2)
    if mod(i,n+2)==0
        A(i,i)=0.5/dx;
        A(i,i-2)=-0.5/dx;
    elseif i<= n+2 || i>n*(n+2)
        A(i,i)=1;
    elseif mod(i,n+2)~=1
        xi=(mod(i,n+2)-1)*dx+a;
        yi=c+(ceil(i/(n+2))-1)*dy;
        A(i,i-n-2)=p(xi,yi)/dy^2;
        A(i,i+n+2)=p(xi,yi)/dy^2;
        A(i,i-1)=1/dx^2;
        A(i,i+1)=1/dx^2;
        A(i,i)=-2/dx^2-2*p(xi,yi)/dy^2+r(xi,yi);
    else
        A(i,i)=1;
    end
end

F=zeros((n+1)*(n+2),1);
for i=1:(n+1)*(n+2)
    xi=(mod(i,n+2)-1)*dx+a;
    yi=c+(ceil(i/(n+2))-1)*dy;
    if mod(i,n+2)==0
        F(i)=-pi*sin(pi*yi);
        %F(i)=-1;
    elseif mod(i,n+2)~=1&&i>n+2&&i<=n*(n+2)
        F(i)=f(xi,yi);
    end
end

u=A\F;

%GS





[x,y]=meshgrid(a:dx:b,c:dy:d);
z=zeros(n+1,n+1);
for i=1:(n+1)
    for j=1:(n+1)
        z(i,j)=u((i-1)*(n+2)+j);
    end
end
z0=sin(pi*x).*sin(pi*y);

mesh(x, y, z);
%contour(x, y, z, 30);

max(max(abs(z-z0)))

%mesh(x,y,z-z0)

function[fun]=p(x,y)
fun=1+x.^2+y.^2;
%fun=1;
end

function[fun]=r(x,y)
fun=-x.*y;
%fun=0;
end

function[fun]=f(x,y)
fun=-(pi^2*(2+x.^2+y.^2)+x.*y).*sin(pi*x).*sin(pi*y);
%if x==0.5 && y==0.5
 %   fun=36^2;
%else
 %   fun=0;
%end
end
