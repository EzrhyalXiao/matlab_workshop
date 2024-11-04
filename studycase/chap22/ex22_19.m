Fs = 1000; 									% 采用频率
T = 1/Fs;									% 采样间隔
L = 1000;									% 信号长度
t = (0:L-1)*T;								% 时间向量
x = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t); 	% 产生正弦合成信号
y = x + 2*randn(size(t)); 					% 添加白噪声
subplot(121);
plot(Fs*t(1:50),y(1:50))
title('原始信号')
xlabel('time (ms)')
NFFT = 2^nextpow2(L); 
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
subplot(122);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('幅值谱')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
