fs1 = 10;							% 原采样频率
t1 = 0:1/fs1:1;						% 时间向量
x = 0.5*t1;							% 时间序列
y = resample(x,3,2);					% 重新采样
t2 = (0:(length(y)-1))*2/(3*fs1);	% 新的时间向量
plot(t1,x,'*',t2,y,'o',-0.5:0.01:1.5,-0.25:0.005:0.75,':')
legend('original','resampled'); xlabel('Time')
