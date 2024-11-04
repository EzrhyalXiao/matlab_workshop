function[Res]=dfm_ar1(y,N,T)
Res.q1=1;
Res.q2=1;
Res.Name=y.Properties.VariableNames;
Res.date=datetime(table2array(y(:,1)));
y=y(:,2:end);
y=table2array(y);
Res.y=y;
w=logical(1-isnan(y));
y=roll_mean_T(y,T,w);
coff=pca(y);
f=zeros(size(y,1),N);
for i=1:size(y,1)
    f(i,:)=y(i,logical(w(i,:)))*coff(logical(w(i,:)),1:N);
end
[A,H,Q,R,likely]=m_step(y,f,w);
judge=inf;
n=1;
while (judge>1e-12)
    [f,K]=e_step(y,w,A,H,Q,R);
    [A,H,Q,R,likely_new]=m_step(y,f,w);
    judge=2*(likely_new-likely)/(abs(likely)+abs(likely_new));
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
Res.mu=0;

end

function[f,A,H,Q,R,K,n]=EM_ite(y,N,w)
%y为原始数据，N为潜在因子数量，w为缺失值矩阵
%f为潜在因子，A为暴露系数，H为隐含因子状态转移系数，
%Q为特质因子方差，R为潜在因子协方差矩阵，n为收敛迭代次数
coff=pca(y);
f=zeros(size(y,1),N);
for i=1:size(y,1)
    f(i,:)=y(i,logical(w(i,:)))*coff(logical(w(i,:)),1:N);
end
[A,H,Q,R,likely]=m_step(y,f,w);
judge=inf;
n=1;
while (judge>1e-12)
    [f,K]=e_step(y,w,A,H,Q,R);
    [A,H,Q,R,likely_new]=m_step(y,f,w);
    judge=2*(likely_new-likely)/(abs(likely)+abs(likely_new));
    likely=likely_new;
    n=n+1;
end
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
function[x_po,K]=KF2(z,A,H,Q,R,W)
%x_k=Ax_k-1+w~Q
%W_k*z_k=W_k*Hx_k+W_k*v~R
%注意向量的格式
%W为缺失值标记
x_po=zeros(size(A,2),size(z,2));
P=0;
x_po(:,1)=((H(logical(W(1,:)),:))'*(H(logical(W(1,:)),:)))\...
(H(logical(W(1,:)),:)'*z(logical(W(1,:)),1));
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
x_po=x_po';
end

function[f,K]=e_step(y,w,A,H,Q,R)
[f,K]=KF2(y',H',A',R,diag(Q),w);
end

function[A,H,Q,R,likely]=m_step(y,f,w)
fy=f(2:end,:);
fs=[f(1:end-1,:)];
H=(fs'*fs)\(fs'*fy);
e2=fy-fs*H;
R=cov(e2);
%H=H';
Q=zeros(size(y,2),1);
A=zeros(size(f,2),size(y,2));
n2=size(e2,1);
m2=size(e2,2);
likely=-(n2*m2)/2*log(2*pi)-n2/2*log(det(R))...
-1/2*trace(e2'*e2/R);
for i=1:size(y,2)
    y2=y(logical(w(:,i)),i);
    fs2=f(logical(w(:,i)),:);
    A(:,i)=(fs2'*fs2)\(fs2'*y2);
    e1=y2-fs2*A(:,i);
    Q(i)=(e1'*e1)/(sum(w(:,i))-size(f,2));
    n1=sum(w(:,i));
    likely=likely-n1/2*log(2*pi)-n1/2*log(Q(i))-1/2*(e1'*e1/Q(i));
end
end
