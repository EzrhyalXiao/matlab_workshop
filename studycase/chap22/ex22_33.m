clear;
fs=1200;     %采样频率
N=300;     % N/fs秒数据
n=0:N-1;
t=n/fs;     %时间
fL=20; 
fH=200;    
s= cos(2*pi*fL*t)+ cos(2*pi*fH*t);
subplot(121);plot(t,s);
title('输入信号'); xlabel('t/s');ylabel('幅度');
sfft=fft(s);
subplot(122);
plot((1:length(sfft)/2)*fs/ length(sfft),2*abs(sfft(1:length(sfft)/2))/ length(sfft));
title('信号频谱'); xlabel('频率/Hz');ylabel('幅度');
%设计低通滤波器：
Wp = 50/fs; Ws = 100/fs;    		%截止频率50Hz,阻带截止频率100Hz,采样频率200Hz
[n,Wn] = buttord(Wp,Ws,1,50);  	%阻带衰减大于50db,通带纹波小于1db
%估算得到Butterworth低通滤波器的最小阶数N和3dB截止频率Wn
[a,b]=butter(n,Wn);     			%设计Butterworth低通滤波器
[h,f]=freqz(a,b,'whole',fs);        	%求数字低通滤波器的频率响应
f=(0:length(f)-1)'*fs/length(f);    	%进行对应的频率转换
figure(2);
plot(f(1:length(f)/2),abs(h(1:length(f)/2)));     	%绘制Butterworth低通滤波器的幅频响应图
title('巴氏低通滤波器'); xlabel('频率/Hz'); ylabel('幅度');
grid;
sF=filter(a,b,s);      				%叠加函数s经过低通滤波器以后的新函数
figure(3);
subplot(121);
plot(t,sF);     					%绘制叠加函数S经过低通滤波器以后的时域图形
title('输出信号');xlabel('t/s');ylabel('幅度');
SF=fft(sF);  
subplot(122);
plot((1:length(SF)/2)*fs/ length(SF),2*abs(SF(1:length(SF)/2))/ length(SF));
title('低通滤波后的频谱图'); xlabel('频率/Hz');ylabel('幅度');
