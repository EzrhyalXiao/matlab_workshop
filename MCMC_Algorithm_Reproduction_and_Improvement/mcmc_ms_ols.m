q=2;
m=1;
x_dim=1;
omega_pri=zeros(m,m,q);
omega_pri(:,:,1)=0.1*eye(m);
omega_pri(:,:,2)=0.2*eye(m);

lcl=log(table2array(ca(5584:end,6)));
lop=log(table2array(ca(5584:end,3)));
intra=lcl-lop;
intra=intra(2:end);
night=lop(2:end)-lcl(1:end-1);

Y=intra;
Z=night;
mu=[0 0 ];
n1=5000;
n2=5000;
pri_P=(0.8-0.2/(q-1))*eye(q)+0.2/(q-1);

[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,mu,4,omega_pri,q,x_dim,n1,n2);
S_esti=mode(S_e,2);
omega_esti=mean(omega_e,4);
smo_pro=smooth_pro(S_e,q);

function[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,pri_mu,pri_omega_N,pri_omega_V,q,dim_x,n1,n2)
%%可以改A的先验
P=gamrnd(pri_P,1,size(pri_P,1),size(pri_P,2));
P=P./sum(P,2);
%A=pri_A;

m=size(Y,2);
A=randn(dim_x,m,q);

omega=zeros(m,m,q);
mu=pri_mu;
for i=1:q
    omega(:,:,i)=wishrnd(pri_omega_V(:,:,i),pri_omega_N);
end
S=drawS(Y,Z,A,mu,P,omega,q);
for i=1:n1
    [omega,A,mu]=draw_theta(Y,Z,pri_omega_N,pri_omega_V,A,mu,omega,S,q);
    S=drawS(Y,Z,A,mu,P,omega,q);
    P=draw_P(S,pri_P);
end   
S_e=zeros(size(S,1),n2);
P_e=zeros(q,q,n2);
A_e=zeros(size(A,1),size(A,2),q,n2);
mu_e=zeros(m,q,n2);
omega_e=zeros(m,m,q,n2);
for i=1:n2
    [omega,A,mu]=draw_theta(Y,Z,pri_omega_N,pri_omega_V,A,mu,omega,S,q);
    S=drawS(Y,Z,A,mu,P,omega,q);
    P=draw_P(S,pri_P);
    S_e(:,i)=S;
    P_e(:,:,i)=P;
    A_e(:,:,:,i)=A;
    mu_e(:,:,i)=mu;
    omega_e(:,:,:,i)=omega;
end

end


function[omega2,A2,mu2]=draw_theta(Y,Z,pri_omega_N,pri_omega_V,A,mu,omega,S,q)
%按照论文顺序
%使用flat prior
m=size(Y,2);
I=eye(q);
class=I(S,:);
N=sum(class,1);
omega2=zeros(m,m,q);
A2=A;
mu2=mu;
%估计A的顺序为mu(写成对角)，alpha，gamma
for i=1:q
    e=class(:,i).*(Y-Z*A(:,:,i)-mu(:,i)');
    Y2=class(:,i).*Y;
    Z2=class(:,i).*Z; 
    I=eye(size(Z,2));
    omega2(:,:,i)=iwishrnd(pri_omega_V(:,:,i)+e'*e,N(i)+pri_omega_N);
    %omega2(:,:,i)=iwishrnd(omega(:,:,i)+e'*e,N(i)+pri_omega_N+m);
    %omega2(:,:,i)=inv(wishrnd(inv(pri_omega_V(:,:,i)+e'*e),N(i)+pri_omega_N));
    A2(:,:,i)=randMN((10*I+Z2'*Z2)\(Z2'*(Y2-mu(:,i)')),inv(10*I+Z2'*Z2),omega2(:,:,i),size(A2,1),size(A2,2));
    R=chol(omega(:,:,i)/(N(i)+1));
    mu2(:,i)=R*randn(m,1)+(sum(Y2-Z2*A2(:,:,i),1))'/(N(i)+1);   
end

end


function[smo_pro]=smooth_pro(S_e,q)
class=zeros(size(S_e,1),q,size(S_e,2));
I=eye(q);
for i=1:size(S_e,2)
    class(:,:,i)=I(S_e(:,i),:);
end
smo_pro=mean(class,3);
end

function[P]=draw_P(S,alpha)
n=size(alpha,1);
times=zeros(n,n);
S1=S(1:end-1);
S2=S(2:end);
for i=1:size(S,1)-1
    times(S1(i),S2(i))=times(S1(i),S2(i))+1;
end

Xs=gamrnd(alpha+times,1,n,n);
P=Xs./sum(Xs,2);
end



function[S]=drawS(Y,Z,A,mu,P,omega,q)
%%Y为dy_t
%%Z为自变量组
%%A为系数 Y=ZA+U+mu'
p0=get_p0(P);
n=size(Y,1);
F=zeros(n,q);
d1=d(Y(1,:),Z(1,:),A,mu,omega,q);
F(1,:)=p0.*d1;%change d(x)
for i=2:n
    d1=d(Y(i,:),Z(i,:),A,mu,omega,q);
    F(i,:)=next_F(F(i-1,:),P,d1);
end


S=zeros(n,1);
S(n)=draw_s(F(n,:));
for j=1:n-1
    k=n-j;
    p=next_p(F(k,:),P,S(k+1));
    
    S(k)=draw_s(p);
end

end



function[p0]=get_p0(P)
[V,D]=eig(P');
D=sum(D,1);
[~,b]=max(D);
p0=V(:,b)';
p0=p0/sum(p0);
end




function[d2]=d(Y,Z,A,mu,omega,q)%change
d2=zeros(1,q);
for j=1:q
e=Y-Z*A(:,:,j)-mu(:,j)';
e=e';

d2(j)=exp(-e'*(omega(:,:,j)\e)/2)/(det(omega(:,:,j)))^0.5;
end
end


function[F2]=next_F(F,P,d)
F2=(F*P).*d;
F2=F2/sum(F2);
end

function[p2]=next_p(F,P,s)


p2=F.*(P(:,s).');

p2=p2/sum(p2);

end

function[s]=draw_s(p)

u=rand();
i=1;
while sum(p(1:i))<u
    i=i+1;
end
s=i;

end

 
function[A]=randMN(M,U,V,m,n)
P=chol(U);
Q=chol(V);
X=randn(m,n);
A=M+P*X*Q';
end
