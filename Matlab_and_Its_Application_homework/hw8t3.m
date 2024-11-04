h=[0.004717427938400
-0.017791870101860
-0.008826800108660
0.109702658642161
-0.045601131884100
-0.342656715382664
0.195766961347502
1.024326944260331
0.853943542705429
0.226418982583462
];
g=h;
for i=1:10
    g(i)=(-1)^(i)*h(11-i);
end
A=zeros(10,10);
B=zeros(10,10);
for i=1:10
    for j=1:10
        xij=2*(i-1)-(j-1);
        if xij<=9&&xij>=0
            A(i,xij+1)=h(j);
            B(i,xij+1)=g(j);
        end
    end
end
%A=A-eye(10);
%A(1,:)=ones(1,10);
F=zeros(10,1);
%F(1)=1;
[V,D]=eig(A);
f=V(:,1)/sum(V(:,1));

m=4;
x=0:2^(-m):9;
phis=zeros(length(x),1);
psis=zeros(length(x),1);
for i=1:length(x)
phis(i)=phi(x(i),f);
psis(i)=psi(x(i),f,g);
end
plot(x,phis)
hold on
plot(x,psis)
hold off

function[y]=phi(x,f)
h=[0.004717427938400 
-0.017791870101860 
-0.008826800108660
0.109702658642161
-0.045601131884100
-0.342656715382664
0.195766961347502
1.024326944260331
0.853943542705429
0.226418982583462
];
if x>=9 || x<=0
    y=0;
elseif x-ceil(x)==0
    y=f(x+1);
else
    y=0;
    for j=1:10
        y=y+h(j)*phi(2*x+1-j,f);
    end
end
end


function[y]=psi(x,f,g)
y=0;
for j=1:10
    y=y+g(j)*phi(2*x+1-j,f);
end
end
