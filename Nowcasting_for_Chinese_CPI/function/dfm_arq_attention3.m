function[Res]=dfm_arq_attention3(data,N,T,q1,q2,attention,lambda,diff_set)


%q1为隐含状态方程滞后阶数，q2为隐含状态转移方程
%y时间前后为上到下
Res.q1=q1;
Res.q2=q2;
Res.T=1;
Res.Name=data.names;
Res.date=data.dates;
Res.Ts=T;

index=0;
for i=1:size(Res.Name,2)
    name=string(Res.Name{i});
    if name==attention
 
        index=i;
    end
end



if index==0
    fprintf('请输入正确的变量名。')
end
attention_adjust=ones(1,size(Res.Name,2));
attention_adjust(index)=lambda;
attention_adjust=attention_adjust*(size(Res.Name,2))/(size(Res.Name,2)+lambda-1);
y=data.y;
%%%%%%%%%%%%%%%%%



if diff_set==1
y_new=y;
diffs=zeros(1,size(y,2));
%%%%%%%%%%%%%%%%%
dy=diff(y);
for i=1:size(y,2)
    if ~adftest(y(:,i),'alpha',0.005)
        y_new(2:end,i)=dy(:,i);
        diffs(i)=1;
    end
end

if sum(diffs)>0
    y=y_new(2:end,:);
    Res.date=Res.date(2:end);
end
Res.diffs=diffs;
end




%y=normalize(y);%%%%%%%
Res.y=y;
w=logical(1-isnan(y));
%y=roll_mean_T(y,T,w);
coff=pca(y);
f=zeros(size(y,1),N);

for i=1:size(y,1)
    f(i,:)=y(i,logical(w(i,:)))*coff(logical(w(i,:)),1:N);
end
[e,A,H,rou,Q,R,mu,likely]=m_step(y,f,w,q1,q2);
judge=inf;
n=1;
while (judge>1e-4)
    [f,K]=e_step(y,e,w,A,H,rou,Q,R,mu,T,q1,q2,attention_adjust);
    [e,A,H,rou,Q,R,mu,likely_new]=m_step(y,f,w,q1,q2);
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
Res.rou=rou;
Res.e=e;
end


%参考《中观行业景气度：Nowcasting 初探》的做法，对数据进行滚动平均处理
%注意缺失值问题


%%用卡尔曼滤波做e-step
function[f,K]=KF2(z,e,A,H,rou,Q,R,mu,W,T,q1,q2,attention_adjust)
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
    %K=(P_new*H(logical(W(i,:)),:)')/((H(logical(W(i,:)),:))*P_new*H(logical(W(i,:)),:)' ...
        %+R(logical(W(i,:)),logical(W(i,:))));
    K=(P_new*H')/(H*P_new*H'+R);
    K=K.*attention_adjust;
    K2=K(:,logical(W(i,:)));
    %K=K.*attention_adjust(logical(W(i,:)));
    Bu=zeros(size(e,1),1);
    for j=1:1:size(e,1)
        if (i-T(j)>0)
           Bu(j,1)=rou(j,1)*e(j,i-T(j));
        end
    end
    for j=1:size(Bu,1)
        if (logical(W(i,j)))&&(isnan(Bu(j)))
            Bu(j)=e(j,i);
        end
    end
    %Bu=e(:,i);
    x_po(:,i)=x_pri+K2*(z(logical(W(i,:)),i)-H(logical(W(i,:)),:)*x_pri-Bu(logical(W(i,:))));
    %disp(i)
    %disp(sum(logical(W(i,:))))
    %disp(31-sum(isnan(Bu)))
    P=P_new-K2*H(logical(W(i,:)),:)*P_new;

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

function[f,K]=e_step(y,e,w,A,H,rou,Q,R,mu,T,q1,q2,attention_adjust)
[f,K]=KF2(y',e',H',A',rou,R,diag(Q),mu',w,T,q1,q2,attention_adjust);
end

function[e,A,H,rou,Q,R,mu,likely]=m_step(y,f,w,q1,q2)
%y=fA,q1 
%f=fH,q2 f左到右为滞后q2项、q2-1项
fy=f(1+q2:end,:);
fs=[];
for i=1:q2
    fs=[f(1+q2-i:end-i,:) fs];
end
H=(fs'*fs)\(fs'*fy);
e2=fy-fs*H;
R=cov(e2);
%H=H';
Q=zeros(size(y,2),1);
rou=zeros(size(y,2),1);
e=zeros(size(y,1),size(y,2))*NaN;
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
    e(logical(w(q1:end,i)),i)=e1;
    e11=e1(1:end-1);
    e12=e1(2:end);
    covs=cov(e11,e12);
    rou(i)=covs(1,2)/covs(1,1);
    ita=e12-e11*rou(i);
    Q(i)=(ita'*ita)/(sum(w(:,i))-size(f,2));
    n1=sum(w(:,i));
    likely=likely-n1/2*log(2*pi)-n1/2*log(Q(i))-1/2*(ita'*ita/Q(i));
end
end
