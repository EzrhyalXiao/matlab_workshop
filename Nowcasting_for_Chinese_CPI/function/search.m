function[selected,R2] = search(Res,r)


F=[];
for i=1:Res.q1
    F=[Res.f(1+Res.q1-i:end+1-i,:) F];
end

real=Res.y;
forecast=0*real;
forecast(1:Res.q1-1)=NaN;
for i=1:size(real,2)
    for j=Res.q1:size(real,1)
        if ~isnan(real(j,i))
            forecast(j,i)=F(j-Res.q1+1,:)*Res.A(:,i)+Res.mu(i);
        end
        if Res.T==1
        %forecast(i)=forecast(i)+Res.e(max(1,i-Ts(index)),index)*Res.rou(index);
        forecast(j,i)=forecast(j,i)+Res.e(max(1,j-1),i)*Res.rou(i);
        %forecast(i)=forecast(i)+Res.e(max(1,i),index);
        end
    end
end


error=real-forecast;
R2=zeros(1,size(real,2));
for i=1:size(R2,2)
    R2(i)=1-cov(error(~isnan(error(:,i)),i))/cov(real(~isnan(real(:,i)),i));
end
selected=(R2>r);

end
