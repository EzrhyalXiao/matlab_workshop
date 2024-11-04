%估计MS-VECM的文件
%%%%%%
q=2;%regime 数
m=2;%向量维度
r=1;%协整数量
lag=29;%VAR阶数
%x=log(table2array(oil(:,6)));
%sh=x(1:807); 
%sp=x(808:end);
%XX=[sh sp];%XX为数据矩阵，行向量形式，列数表示样本数。

%sh=log(table2array(ca2(72:end,6)));
%sp=log(table2array(ca2S1(72:end,6)));
%XX=[sh sp];
close=log(table2array(ca(:,6)));
close=close(3701:6057-1);
open=log(table2array(ca(:,3)));
open=open(3702:6057);
XX=[close open];

omega_pri=zeros(m,m,q);%误差协方差矩阵的先验分布，维度3为对应regime
omega_pri(:,:,1)=0.1*eye(m);
omega_pri(:,:,2)=0.3*eye(m);
%omega_pri(:,:,3)=0.9*eye(m);
beta=[-1; 1];%协整矩阵
mu=[0 0 ;0 0 ];%截距先验，维度2为对应regime
n1=10000;%burn draws
n2=10000;%估计采样数
pri_P=(0.8-0.2/(q-1))*eye(q)+0.2/(q-1);%转移矩阵先验

%%%%%%以上为输入区域


DX=diff(XX,1);
Y=DX(1+lag:end,:);
n=size(Y,1);
Z=zeros(n,m*lag+r);

Z(:,1:r)=XX(1+lag:end-1,:)*beta;
for i=1:lag
    Z(:,i*m+r-m+1:i*m+r)=DX(lag+1-i:end-i,:);
end


%S_e,P_e,A_e,mu_e,omega_e分别为regime、转移矩阵、VEC系数、截距、误差协方差矩阵的每一轮采样
%参数维度含义：
%S_e指标一表示时刻，指标二表示采样数
%P_e指标一、二表示转移矩阵，指标三表示采样数
%A_e指标一、二表示VEC系数，指标三表示对应regime，指标四表示采样数
%mu_e指标一表示截距，指标二表示对应regime，指标三表示采样数
%omega_e指标一、二表示误差协方差矩阵，指标三表示对应regime，指标四表示采样数

%%%%%
[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,mu,4,omega_pri,q,lag,r,n1,n2);
S_esti=mode(S_e,2);%regime估计
omega_esti=mean(omega_e,4);%误差协方差矩阵估计
%right=mean(S(lag+1:end)==S_esti);
smo_pro=smooth_pro(S_e,q);%计算平滑概率
%%%%%以上为结果输出


function[S_e,P_e,A_e,mu_e,omega_e]=gibbs_A(Y,Z,pri_P,pri_mu,pri_omega_N,pri_omega_V,q,lag,r,n1,n2)
%%可以改A的先验
P=gamrnd(pri_P,1,size(pri_P,1),size(pri_P,2));
P=P./sum(P,2);
%A=pri_A;

m=size(Y,2);
A=randn(m*lag+r,m,q);

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


 

function[A]=randMN(M,U,V,m,n)
P=chol(U);
Q=chol(V);
X=randn(m,n);
A=M+P*X*Q';
end

