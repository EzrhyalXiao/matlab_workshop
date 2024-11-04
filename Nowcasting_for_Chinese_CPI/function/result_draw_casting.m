function[R2] = result_draw_casting(Res,Variable)
index=0;
for i=1:size(Res.y,2)+1
    name=string(Res.Name{i});
    if name==Variable
        index=i-1;
    end
end
if index==0
    fprintf('请输入正确的变量名。')
end


F=[];
for i=1:Res.q1
    F=[Res.f(1+Res.q1-i:end+1-i,:) F];
end

real=Res.y(:,index);
forecast=0*real;
forecast(1:Res.q1-1)=NaN;
for i=Res.q1:size(real,1)
    if ~isnan(real(i))
        forecast(i)=F(i-Res.q1+1,:)*Res.A(:,index)+Res.mu(index);
    end
    if Res.T==1
        forecast(i)=forecast(i)+Res.e(max(1,i-1),index)*Res.rou(index);
    end
end


plot(Res.date,real,'k')
hold on
scatter(Res.date,forecast,'x')
%plot(Res.date,forecast,'b')

error=real-forecast;
R2=1-cov(error(~isnan(error)))/cov(real(~isnan(real)));
%text(Res.date(ceil(end/2)),max(real),['预测R^2=' string(round(R2,3))])
legend([Variable '实际值'],[Variable '预测值'],Location="southoutside")
title([Variable '实际值与预测值'])

fprintf('预测R^2=%.4f',R2)
hold off


end