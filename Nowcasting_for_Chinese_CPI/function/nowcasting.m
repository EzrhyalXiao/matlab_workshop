function [real,forecasts,adjust,f,weight,e_new] = nowcast3(Res,newdata,Variable)
index=0;
for i=1:size(Res.Name,2)
    name=string(Res.Name{i});
    if name==Variable
        index=i;
    end
end
if index==0
    fprintf('请输入正确的变量名。')
end

date=newdata.dates;
newdata=newdata.y;
A=Res.H;
H=Res.A;
mu=Res.mu;
Q=Res.R;
R=diag(Res.Q);
A=A';
H=H';

mu=mu';

w=logical(1-isnan(newdata));
q1=Res.q1;
q2=Res.q2;
q=max(q1,q2);
N=size(Res.f,2);
x0=zeros(q*N,1);
for i=1:q
    x0(end+1-i*N:end-(i-1)*N)=Res.f(end+1-i,:)';
end
if Res.T==1
    e_old=Res.e;
    rou=Res.rou;
    [f,e_new,adjust,K1,forecasts2]=KF1(newdata',x0,e_old,A,H,rou,Q,R,mu,w,Res.Ts,q1,q2,Res.K,Res.A(:,index));
else
    [f,adjust,K1,forecasts2]=KF2(newdata',x0,A,H,Q,R,mu,w,q1,q2,Res.K,Res.A(:,index));
end

forecasts2=forecasts2';
forecasts2=forecasts2+Res.mu;
weight=K1(end-N+1:end,:)'*Res.A(:,index);
adjust=adjust';
f=[Res.f(end+2-q1:end,:);f];
F=[];
for i=1:q1
    F=[f(1+Res.q1-i:end+1-i,:) F];
end

real=newdata(:,index);
forecasts=zeros(size(newdata,1),size(newdata,2));

for i=1:size(real,1)
        forecasts(i,:)=F(i,:)*Res.A+Res.mu;
end
if Res.T==1
    for i=1:size(real,1)
        forecasts(i,:)=forecasts(i,:)+rou'.*e_new(i,:);
        %forecasts(i,:)=forecasts(i,:)+e_new(i+1,:);
        %forecasts2(i,:)=forecasts2(i,:)+e_new(i+1,:);
    end
end
%disp(rou'.*e_new(size(real,1),:))


%forecasts是后验修正结果，forecasts2是先验预测
%plot(date(1:end-1),real(1:end-1),'Color',[255 0 0]/255)
plot(date,real,'Color',[255 0 0]/255)
hold on
plot(date(1:end),forecasts(1:end,index),'-.','Color',[4 78 126]/255)
%plot(date(1:end-1),forecasts2(2:end,index),'.','Color',[4 78 126]/255)
%scatter(date,forecasts2(:,index),'x')
%plot(Res.date,forecast,'b')

error=real-forecasts(:,index);
R2=1-cov(error(~isnan(error)))/cov(real(~isnan(real)));
%text(Res.date(ceil(end/2)),max(real),['预测R^2=' string(round(R2,3))])
legend([Variable '实际值'],[Variable '预测值'],Location="southoutside")
title([Variable '实际值与预测值'])

fprintf('预测R^2=%.4f',R2)
hold off

end


function[f,e_new,x_adjust,K1,forecasts2]=KF1(z,x0,e,A,H,rou,Q,R,mu,W,T,q1,q2,K1,loading)
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
x_po=zeros(N*q,size(z,1)+1);
e_new=zeros(size(R,1),size(z,2)+size(e,1));
e_new(:,1:size(e,1))=e';
%%%x_adjust=zeros(N*q,1);
P=zeros(size(A,2),size(A,2));

if q2>q1
    H=[zeros(size(H,1),(q-q1)*N) H];
end

%%%%%任意初始化
attention_adjust=ones(1,size(z,1));
attention_adjust(end)=1;
attention_adjust=attention_adjust*(size(z,1))/(size(z,1)+attention_adjust(end)-1);
K1=K1.*attention_adjust;
forecasts2=0*z;
x_po(:,1)=x0;

x_adjust=zeros(size(z,1),size(z,2));
for j=2:size(z,2)+1
    i=j-1;
    ti=j-1+size(e,1);
    x_pri=A*x_po(:,i);
    P_new=A*P*A'+Q;
    K=K1(:,logical(W(i,:)));
    %K=(P_new*H(logical(W(i,:)),:)')/((H(logical(W(i,:)),:))*P_new*H(logical(W(i,:)),:)' ...
        %+R(logical(W(i,:)),logical(W(i,:))));
    %%%x_adjust(:,i-1)=K*(z(logical(W(i,:)),i)-H(logical(W(i,:)),:)*x_pri);
    Bu=zeros(size(e,2),1);
    for k=1:size(e,2)
        Bu(k,1)=rou(k,1)*e_new(k,ti-T(k));
    end
    for k=1:size(Bu,1)
        if (logical(W(i,k)))&&(isnan(Bu(k)))
            Bu(k)=e_new(k,ti);
        end
    end
    x_po(:,j)=x_pri+K*(z(logical(W(i,:)),i)-H(logical(W(i,:)),:)*x_pri-Bu(logical(W(i,:))));
    %forecasts2(logical(W(i,:)),i)=(H(logical(W(i,:)),:)*x_pri);
     for k=1:size(Bu,1)
        if ~logical(W(i,k))
            e_new(k,ti)=rou(k,1).*e_new(k,ti-T(k));
            %e_new(k,ti)=rou(k,1).*e_new(k,ti-1);
        else
            e_new(k,ti)=z(k,i)-H(k,:)*x_po(:,j);
        end
    end
    
    
    for k=1:size(Bu,1)
        if ~logical(W(i,k))
            e_new(k,ti)=rou(k,1)*e_new(k,ti-T(k));
        end
    end
    forecasts2(:,i)=(H*x_pri)+Bu;
    %forecasts2(:,i)=(H*x_po(:,j))+e_new(:,ti);
    x_adjust(logical(W(i,:)),i)=(loading'*K(end-N+1:end,:))'.*(z(logical(W(i,:)),i)-H(logical(W(i,:)),:)*x_pri-Bu(logical(W(i,:))));
    P=P_new-K*H(logical(W(i,:)),:)*P_new;
end
%P_new=A*P*A'+Q;
%K=(P_new*H')/(H*P_new*H'+R);
x_po=x_po(:,2:end);
f=zeros(size(z,2),N);
e_new=e_new(:,size(e,1):end);
e_new=e_new';

for i=1:size(z,2)-q+1
    f(i,:)=x_po(1:N,i)';
end
for i=2:q
    index_time=size(z,2)-q+i;
    f(index_time,:)=x_po(i*N-N+1:i*N,end)';
end

end


