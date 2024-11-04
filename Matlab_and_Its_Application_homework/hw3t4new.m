c11=20;
f=@(x)-c11*exp(-0.2*sqrt(sum(x.^2)/length(x)))-exp(sum(cos(2*pi*x))/length(x))+c11+exp(1);
m=300;
lim=10;
w=0;
n=10;
c1=0.6;
c2=1;
v0=1;
t=0.1;
type=2;
tol=1.e-5;
k_max=300;
pso_sol(f,lim,m,n,tol,k_max,w,c1,c2,t,v0,type);
%pso_draw(f,lim,m,n,tol,k_max,w,c1,c2,t,v0,type,0.1)

function[points_next,vector_next,position_next,pgd,val,val_m]=pso(f,points,vector,position,w,c1,c2,t)
num=size(points,1);
values=zeros(num,1);
for i=1:num
    values(i)=f(position(i,:));
    if f(points(i,:))<f(position(i,:))
        position(i,:)=points(i,:);
    end
end
[~,pgd_hao]=min(values);
pgd=position(pgd_hao,:);
r1=diag(rand(1,num));
r2=diag(rand(1,num));
vector_next=w*vector+c1*r1*(position-points)+c2*r2*(pgd-points);
points_next=points+vector_next*t;
for i=1:num
    values(i)=f(points_next(i,:));
end
[val,pgd_hao]=min(values);
pgd=points_next(pgd_hao,:);
val_m=mean(values);
position_next=position;
end

function[pdg,val_min,k]=pso_sol(f,lim,m,n,tol,k_max,w,c1,c2,t,v0,type)
zuobiao=rand(m,n);
points_1=zuobiao*2*lim-lim;
vec_1=(rand(m,n)-0.5)*v0;
position_1=points_1;
decr=-1;
val_1=f(points_1(1,:));
k=0;
while abs(decr)>tol && k<k_max
[points_1,vec_1,position_1,pdg,val_min,val_m]=pso(f,points_1,vec_1,position_1,w,c1,c2,t);
if type==1
    decr=val_min-val_1;
    val_1=val_min;
else 
    decr=val_m-val_1;
    val_1=val_m;
end
%fprintf('%f\n',decr);
val_2=val_min;
k=k+1;
end
fprintf('迭代次数为：%d \n',k);
fprintf('最小值为：%f \n',val_2);
fprintf('最小值点为：');
disp(pdg);
end

function[pdg,val_min]=pso_draw(f,lim,m,n,tol,k_max,w,c1,c2,t,v0,type,p)
zuobiao=rand(m,n);
points_1=zuobiao*2*lim-lim;
position_1=points_1;
vec_1=(rand(m,n)-0.5)*v0;
decr=-1;
val_1=0;
pieces=zeros(k_max,m);
pdgs=zeros(k_max,1);
pieces(1,:)=points_1;
k=0;
while abs(decr)>tol &&k<k_max
[points_1,vec_1,position_1,pdg,val_min,val_m]=pso(f,points_1,vec_1,position_1,w,c1,c2,t);
if type==1
    decr=val_min-val_1;
    val_1=val_min;
else 
    decr=val_m-val_1;
    val_1=val_m;
end
k=k+1;
pieces(k,:)=points_1;
%val_2=val_min;
pdgs(k)=pdg;%%
end
x=-lim:0.05:lim;
f_x=zeros(1,length(x));
for i=1:length(x)
    f_x(i)=f(x(i));
end
for i=1:k
p_f=zeros(m,1);
for j=1:m
    p_f(j)=f(pieces(i,j));
end
plot(x,f_x)
hold on
scatter(pieces(i,:),p_f)
scatter(pdgs(i),f(pdgs(i)),'yellow')
axis([-lim lim 0 30]);
title(sprintf('k = %d',i)); 
pause(p); 
hold off
end
end
