function  [th,err,yi]=polyfits(x,y,N,xi,r)
%x,y:数据点系列
%N ：多项式拟合的系统
%r  ：加权系数的逆矩阵

M=length(x);
x=x(:);
y=y(:);

%判断调用函数的格式
if nargin==4
%当调用函数的格式为（x,y,N,r）
   if length(xi)==M
          r=xi;
          xi=x;
%当调用函数的格式为(x,y,N,xi)
     else r=1;
     end
%当调用格式为(x,y,N)
elseif nargin==3
         xi=x;
         r=1;
end
%求解系数矩阵
A(:,N+1)=ones(M,1);
for n=N:-1:1
      A(:,n)=A(:,n+1).*x;
end
if length(r)==M
       for m=1:M
            A(m,:)=A(m,:)/r(m);
            y(m)=y(m)/r(m);
       end
end
  %计算拟合系数
th=(A\y)';
ye=polyval(th,x);
err=norm(y-ye)/norm(y);
yi=polyval(th,xi);
