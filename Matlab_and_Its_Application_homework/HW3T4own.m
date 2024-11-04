f=@(x)-c11*exp(-0.2*sqrt(sum(x.^2)/length(x)))-exp(sum(cos(2*pi*x))/length(x));
c11=20;
m=100;
lim=5;
w=0.5;
c1=0.1;
c2=1;
t=0.2;
type=1;
tol=1.e-5;
k_max=30;
f_unc=@(x) 10*x(1)^3+x(1)*x(2)^2+x(3)*(x(1)^2+x(2)^2);
Schaffer=@(x)0.5+(sin(sqrt(sum(x.^2)))^2-0.5)./(1+0.001*sum(x.^2))^2 ;
%pso_draw(f,lim,m,1,tol,k_max,w,c1,c2,t,type)
%pso_sol(Schaffer,lim,100,2,tol,k_max,w,c1,c2,t,type);
pso_sol_con(f_unc,my_con,lim,100,3,tol,k_max,w,c1,c2,t,type);

function[c,ceq]=my_con(x)
c(1)=sqrt(x(1)^2+x(2)^2)-x(3)-10;
c(2)=sqrt(x(1)^2+x(2)^2)+x(3)-3;
ceq=[];
end

function[pdg,val_min,k]=pso_sol(f,lim,m,n,tol,k_max,w,c1,c2,t,type)
zuobiao=rand(m,n);
points_0=zuobiao*2*lim-lim;
vector_0=rand(m,n)-0.5;
decr=-1;
[points_1,vec_1,val_1]=pso(f,points_0,vector_0,w,c1,c2,t);
k=1;
while abs(decr)>tol & k<=k_max
[points_1,vec_1,pdg,val_min,val_m]=pso(f,points_1,vec_1,w,c1,c2,t);
if type==1
    decr=val_min-val_1;
    val_1=val_min;
else 
    decr=val_m-val_1;
    val_1=val_m;
end
k=k+1;
end
fprintf('迭代次数为：%d \n',k);
fprintf('最小值为：%f \n',val_1);
fprintf('最小值点为：');
disp(pdg);
end

function[pdg,val_min,k]=pso_sol_con(f,cons,lim,m,n,tol,k_max,w,c1,c2,t,type)
zuobiao=rand(m,n);
points_0=zuobiao*2*lim-lim;
vector_0=rand(m,n)-0.5;
decr=-1;
[points_1,vec_1,val_1]=pso(f,points_0,vector_0,w,c1,c2,t);
k=1;
while abs(decr)>tol & k<=k_max
[points_1,vec_1,pdg,val_min,val_m]=pso_con(f,cons,points_1,vec_1,w,c1,c2,t);
if type==1
    decr=val_min-val_1;
    val_1=val_min;
else 
    decr=val_m-val_1;
    val_1=val_m;
end
k=k+1;
end
fprintf('迭代次数为：%d \n',k);
fprintf('最小值为：%f \n',val_1);
fprintf('最小值点为：');
disp(pdg);
end

function[pdg,val_min]=pso_draw(f,lim,m,n,tol,k_max,w,c1,c2,t,type)
zuobiao=rand(m,n);
points_0=zuobiao*2*lim-lim;
vector_0=rand(m,n)-0.5;
decr=-1;
pieces=zeros(k_max,m);
[points_1,vec_1,val_1]=pso(f,points_0,vector_0,w,c1,c2,t);
pieces(1,:)=points_1;
k=1;
while abs(decr)>tol &&k<k_max
[points_1,vec_1,pdg,val_min,val_m]=pso(f,points_1,vec_1,w,c1,c2,t);
if type==1
    decr=val_min-val_1;
    val_1=val_min;
else 
    decr=val_m-val_1;
    val_1=val_m;
end
k=k+1;
pieces(k,:)=sort(points_1);
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
axis([-lim lim val_1 0]);
title(sprintf('k = %d',i)); 
pause(1); 
hold off
end
end

function[points_next,vector_next,pgd,val,val_m]=pso(f,points,vector,w,c1,c2,t)

num=size(points,1);
position=points;
values=zeros(num,1);
for i=1:num
    [position(i,:),values(i)]=fminunc(f,points(i,:));
end
r1=diag(rand(1,num));
r2=diag(rand(1,num));
[~,pgd_hao]=min(values);
pgd=position(pgd_hao,:);
vector_next=w*vector+c1*r1*(position-points)+c2*r2*(pgd-points);
points_next=points+vector_next*t;
for i=1:num
    values(i)=f(points_next(i,:));
end
[val,pgd_hao]=min(values);
pgd=points_next(pgd_hao,:);
val_m=mean(values);
end

function[points_next,vector_next,pgd,val,val_m]=pso_con(f,cons,points,vector,w,c1,c2,t)
num=size(points,1);
position=points;
values=zeros(num,1);
for i=1:num
    [position(i,:),values(i)]=fmincon(f_unc,points(i,:),[],[],[],[],[],[],cons);
end
r1=diag(rand(1,num));
r2=diag(rand(1,num));
[~,pgd_hao]=min(values);
pgd=position(pgd_hao,:);
vector_next=w*vector+c1*r1*(position-points)+c2*r2*(pgd-points);
points_next=points+vector_next*t;
for i=1:num
    values(i)=f(points_next(i,:));
end
[val,pgd_hao]=min(values);
pgd=points_next(pgd_hao,:);
val_m=mean(values);
end