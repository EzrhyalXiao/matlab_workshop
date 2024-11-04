
%x=zeros(n2,1);
%x(1:end)=A_e(1,1,1,:);
x=zeros(size(smo_pro,1),1);
x(1:end)=smo_pro(:,2);

y=table2array(ca(end-size(x,1)+1:end,1));
date=datetime(y);
plot(date,x)
hold on
rc=close(2:end)-close(1:end-1);
rc=rc(lag+1:end);
%plot(date,rc*10)
title('区制2的平滑概率')
hold off
alpha=zeros(m,q);
t=zeros(m,q);
for i=1:q
    alpha(:,i)=mean(A_e(1,:,i,:),4);
    t(:,i)=mean(A_e(1,:,i,:),4)./std(A_e(1,:,i,:),0,4);
end
fprintf('α的估计结果，列表示区制1、2：\n')
disp(alpha)
fprintf('α的t统计量，列表示区制1、2：\n')
disp(t)