function[Res]=dfm_arq(y,N,T,q1,q2)
%q1为隐含状态方程滞后阶数，q2为隐含状态转移方程
%y时间前后为上到下
Res.q1=q1;
Res.q2=q2;
Res.T=0;
Res.Name=y.Properties.VariableNames;
Res.date=datetime(table2array(y(1:end,1)));
y=y(:,2:end);
y=table2array(y);
%%%%%%%%%%%%%%%%%


%y=normalize(y);%%%%%%%



Res.y=y;
w=logical(1-isnan(y));
y=roll_mean_T(y,T,w);
coff=pca(y);
f=zeros(size(y,1),N);
for i=1:size(y,1)
    f(i,:)=y(i,logical(w(i,:)))*coff(logical(w(i,:)),1:N);
end
[A,H,Q,R,mu,likely]=m_step(y,f,w,q1,q2);
judge=inf;
n=1;
while (judge>1e-4)
    [f,K]=e_step(y,w,A,H,Q,R,mu,q1,q2);
    [A,H,Q,R,mu,likely_new]=m_step(y,f,w,q1,q2);
    judge=2*(likely_new-likely)/(abs(likely)+abs(likely_new));
    if judge<0
        fprintf('似然判据为%.4f，模型不恰当。',judge)
    end
    likely=likely_new;
    n=n+1;
end
Res.f=f;
Res.A=A;
Res.H=H;
Res.Q=Q;
Res.R=R;
Res.K=K;
Res.n=n;
Res.mu=mu;
end


%参考《中观行业景气度：Nowcasting 初探》的做法，对数据进行滚动平均处理
%注意缺失值问题
function[y_roll]=roll_mean_T(y,T,w)
Ts=unique(T);
T_max=Ts(1);
for i=2:size(Ts,2)
    T_max=lcm(T_max,Ts(i));
end
y_roll=y;
for i=1:size(y,2)
    for j=1:size(y,1)
        if w(j,i)==1
            y_for_mean=y(max(j-T_max+T(i),1):T(i):j,i);
            Z=(~isnan(y_for_mean));
            y_roll(j,i)=mean(y_for_mean(Z));
        end
    end
end
end


%%用卡尔曼滤波做e-step
function[f,K]=KF2(z,A,H,Q,R,mu,W,q1,q2)
%x_k=Ax_k-1+w~Q
%W_k*z_k=W_k*Hx_k+W_k*mu+W_k*v~R x向量上到下为滞后q1 q1-1 q1-2...
%注意向量的格式
%W为缺失值标记
z=z-mu;
q=max(q1,q2);
N=size(Q,1);
A_new=zeros(q*N,q*N);
Q_new=A_new;
Q_new(1:N,1:N)=Q;
A_new(end-N+1:end,end+1-N*q2:end)=A;
for i=2:q
    A_new(end-i*N+1:end-i*N+N,end+1-N*i+N:end-i*N+2*N)=eye(N);
    Q_new(i*N-N+1:i*N,i*N-N+1:i*N)=Q;
end
A=A_new;
Q=Q_new;
x_po=zeros(N*q,size(z,1)+1-q);
P=zeros(size(A,2),size(A,2));
if q1>=q2
    x_po(:,1)=((H(logical(W(1,:)),:))'*(H(logical(W(1,:)),:)))\...
(H(logical(W(1,:)),:)'*z(logical(W(1,:)),1));
end
if q2>q1
    lag=q1*N;
    for i=1:floor(q2/q1)
         x_po(i*lag-lag+1:(i*lag),1)=((H(logical(W(1,:)),:))'*(H(logical(W(1,:)),:)))\...
     (H(logical(W(1,:)),:)'*z(logical(W(1,:)),i));
    end
    x_po(end+1-lag:end,1)=((H(logical(W(1,:)),:))'*(H(logical(W(1,:)),:)))\...
     (H(logical(W(1,:)),:)'*z(logical(W(1,:)),floor(q2/q1)+1));
    H=[zeros(size(H,1),(q-q1)*N) H];
end

%%%%%任意初始化？
%x_po(:,1)=1;
for i=2:size(z,2)
    x_pri=A*x_po(:,i-1);
    P_new=A*P*A'+Q;
    K=(P_new*H(logical(W(i,:)),:)')/((H(logical(W(i,:)),:))*P_new*H(logical(W(i,:)),:)' ...
        +R(logical(W(i,:)),logical(W(i,:))));
    x_po(:,i)=x_pri+K*(z(logical(W(i,:)),i)-H(logical(W(i,:)),:)*x_pri);
    P=P_new-K*H(logical(W(i,:)),:)*P_new;
end
%P_new=A*P*A'+Q;
%K=(P_new*H')/(H*P_new*H'+R);
f=zeros(size(z,2),N);
for i=1:size(z,2)-q+1
    f(i,:)=x_po(1:N,i)';
end
for i=2:q
    index_time=size(z,2)-q+i;
    f(index_time,:)=x_po(i*N-N+1:i*N,end)';
end

end

function[f,K]=e_step(y,w,A,H,Q,R,mu,q1,q2)
[f,K]=KF2(y',H',A',R,diag(Q),mu',w,q1,q2);
end

function[A,H,Q,R,mu,likely]=m_step(y,f,w,q1,q2)
%y=fA,q1 
%f=fH,q2 f左到右为滞后q2项、q2-1项
fy=f(1+q2:end,:);
fs=[];
for i=1:q2
    fs=[f(1+q2-i:end-i,:) fs];
end
H=(fs'*fs)\(fs'*fy);
mu=H(1,:);
e2=fy-fs*H;
R=cov(e2);
%H=H';
Q=zeros(size(y,2),1);
A=zeros(q1*size(f,2),size(y,2));
n2=size(e2,1);
m2=size(e2,2);
likely=-(n2*m2)/2*log(2*pi)-n2/2*log(det(R))...
-1/2*trace(e2'*e2/R);
fs2=[];
for j=1:q1
    fs2=[f(1+q1-j:end+1-j,:) fs2];
end
mu=zeros(1,size(y,2));
for i=1:size(y,2)
    y2=y(q1:end,i);
    y2=y2(logical(w(q1:end,i)),:);
    %暂不考虑数据频率对滞后阶数的影响
    fs3=fs2(logical(w(q1:end,i)),:);
    fs3=[ones(size(fs3,1),1) fs3];
    As=(fs3'*fs3)\(fs3'*y2);
    mu(i)=As(1);
    A(:,i)=As(2:end);
    e1=y2-fs3*As;
    Q(i)=(e1'*e1)/(sum(w(:,i))-size(f,2));
    n1=sum(w(:,i));
    likely=likely-n1/2*log(2*pi)-n1/2*log(Q(i))-1/2*(e1'*e1/Q(i));
end
end



