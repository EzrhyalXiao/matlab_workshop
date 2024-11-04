function [] = nowcast(Res,Newtime,Variable)
index=0;
for i=1:size(Res.y,2)
    name=string(Res.Name{i});
    if name==Variable
        index=i-1;
    end
end
if index==0
    fprintf('请输入正确的变量名。')
end
forecast1=Res.f(end,:)*Res.A(:,index);
weight=(Res.A(:,index))'*Res.K;
data_new= readtable(Newtime);
%time_new=size(datetime(table2array(data_new(:,1))),1);
%forecast_time=time_new-size(Res.y,1)+1;
C={string(Res.Name(2)),weight(1)};
for i=2:size(weight,2)
    C(i,:)={string(Res.Name(i+1)),weight(i)};
end

fprintf('修正权重：\n')
disp(C)
C2={};
data_new=table2array(data_new(:,2:end));

forecast3=forecast1;
j=0;
for i=1:size(data_new,2)
    if isnan(Res.y(end,i))&&(~isnan(data_new(end,i)))
        j=j+1;
        forecast2=Res.f(end,:)*Res.A(:,i);
        adjust=weight(i)*(data_new(end,i)-forecast2);
        C2(j,:)={string(Res.Name(i+1)),adjust};
        forecast3=forecast3+adjust;
    end
end

fprintf('新发布信息修正：\n')
disp(C2)
fprintf('旧预测值为：\n')
disp(forecast3)
fprintf('新预测值为：\n')
disp(forecast3)


end

