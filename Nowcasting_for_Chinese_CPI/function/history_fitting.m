function[R2] = history_fitting(Res,Variable)
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


F=[];
for i=1:Res.q1
    F=[Res.f(1+Res.q1-i:end+1-i,:) F];
end
Ts=Res.Ts;
real=Res.y(:,index);
forecast=0*real;
forecast(1:Res.q1-1)=NaN;
for i=Res.q1:size(real,1)
    if ~isnan(real(i))
        forecast(i)=F(i-Res.q1+1,:)*Res.A(:,index)+Res.mu(index);
    end
    if Res.T==1
        if isnan(Res.e(max(1,i-Ts(index)),index))
            forecast(i)=forecast(i)+Res.e(max(1,i),index);
        else
            forecast(i)=forecast(i)+Res.e(max(1,i-1),index)*Res.rou(index);
        end
        %forecast(i)=forecast(i)+Res.e(max(1,i-1),index)*Res.rou(index);
        %forecast(i)=forecast(i)+Res.e(max(1,i),index);
    end
end

dates=Res.date(~isnan(real));

plot(dates,real(~isnan(real)),'Color',[255 0 0]/255)
hold on
plot(dates,forecast(~isnan(real)),'Color',[4 78 126]/255)
%plot(Res.date,forecast,'b')

error=real-forecast;
R2=1-cov(error(~isnan(error)))/cov(real(~isnan(real)));
%text(Res.date(ceil(end/2)),max(real),['预测R^2=' string(round(R2,3))])
legend([Variable '实际值'],[Variable '预测值'],Location="southoutside")
title([Variable '实际值与预测值'])

fprintf('预测R^2=%.4f',R2)
hold off


end