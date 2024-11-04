%MS-VAR，蒙特卡罗测试文件

P=[0.9 0.1 ;0.2 0.8 ];


omega=zeros(2,2,2);
omega(:,:,1)=[1 0;0 1];
omega(:,:,2)=[4 -2;-2 9];


n=600;
q=2;
m=2;
lag=3;
y0=10*randn(lag,m);
theta=zeros(m,m,lag,q);
theta(:,:,1,1)=[0.4 0;0 0.5];
theta(:,:,2,1)=[0.2 0;0 0.2];
theta(:,:,3,1)=[-0.1 0;0 -0.1];

theta(:,:,1,2)=[0.1 -0.1;-0.3 0.6];
theta(:,:,2,2)=[-0.1 0;-0.2 -0.5];
theta(:,:,3,2)=[0.05 0;-0.4 0.4];


omega_pri=zeros(m,m,q);
omega_pri(:,:,1)=0.1*eye(m);
omega_pri(:,:,2)=0.5*eye(m);


mu=[0.7 0.5 ;0.2 0.6];
A=zeros(m*(lag+1),m,q);
for i=1:q
   A(1:m,:,i)=diag(mu(:,i));
    for j=1:lag
         A(j*m+1:(j+1)*m,:,i)=(theta(:,:,j,i))';
    end
   
end

A0=A(m+1:end,:,:);

S=markov(P,1,n+lag);
%y=gen_var(S,A,omega,y0,m,q,lag);
y=gen_var(S,theta,mu,omega,y0,m,q,lag);
n1=3000;
n2=3000;
pri_P=[0.8 0.2 ;0.2 0.8];
Y=y(lag+1:end,:);
Z=zeros(n,m*lag);
for i=1:lag
   Z(:,i*m+1-m:i*m)=y(lag+1-i:end-i,:);
end
[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,A0,mu,4,omega_pri,q,lag,n1,n2);
%[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y2,Z2(:,3:4),pri_P,A0,mu,4,omega_pri,q,1,n1,n2);
S_esti=mode(S_e,2);
omega_esti=mean(omega_e,4);

right=mean(S(lag+1:end)==S_esti);
fprintf('区制估计准确率为：\n')
disp(right)
fprintf('残差协方差矩阵估计误差为：\n')
disp((omega-omega_esti))
fprintf('VAR参数估计误差为：\n')
disp((A0-mean(A_e,4)))

function[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,pri_A,pri_mu,pri_omega_N,pri_omega_V,q,lag,n1,n2)
%%可以改A的先验
P=gamrnd(pri_P,1,size(pri_P,1),size(pri_P,2));
P=P./sum(P,2);
%A=pri_A;

m=size(Y,2);
A=randn(m*lag,m,q);

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
P_e=zeros(m,m,n2);
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
    A2(:,:,i)=randMN((I+Z2'*Z2)\(Z2'*(Y2-mu(:,i)')),inv(I+Z2'*Z2),omega2(:,:,i),size(A2,1),size(A2,2));
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
%R=chol(omega(:,:,j));
%u=R'\e;
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

function[y]=gen_var(S,theta,mu,omega,y0,m,q,lag)
n=size(S,1);
y=zeros(n+lag,m);
y(1:lag,:)=y0;
F=zeros(m,m,q);
for i=1:q
    F(:,:,i)=chol(omega(:,:,i));
end
for i=1:n
    for j=1:lag
        y(i+lag,:)= y(i+lag)+theta(:,:,j,S(i))*y(i+lag-j,:)';
    end
    y(i+lag,:)= y(i+lag,:)+(F(:,:,S(i))*randn(m,1))'+mu(:,S(i))';
end
y=y(1+lag:end,:);

end
 

function[A]=randMN(M,U,V,m,n)
P=chol(U);
Q=chol(V);
X=randn(m,n);
A=M+P*X*Q';
end

function[regime]=markov(P,Q0,n)
regime=zeros(n,1);
regime(1)=Q0;
for i=2:n
    u=rand(1);
    j=1;
    while u>sum(P(regime(i-1),1:j))
        j=j+1;
    end
    regime(i)=j;
end
end