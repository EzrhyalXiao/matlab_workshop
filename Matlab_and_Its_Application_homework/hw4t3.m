t1=table2array(data1(:,1));
x1=table2array(data1(:,2));
y=fft(x1);


mark=[];
for i=1:length(y)
    if y(i)<1000
        y(i)=0;
    else
        mark=[mark i];
    end
end
X1=ifft(y);
plot(t1,x1)
hold on
dw=2*pi/(t1(length(t1))-t1(1));
W=(mark-1)*dw;
sin1=sin(W(1)*t1);
cos1=cos(W(1)*t1);
sin2=sin(W(2)*t1);
cos2=cos(W(2)*t1);
sin3=sin(W(3)*t1);
cos3=cos(W(3)*t1);
sin4=sin(W(4)*t1);
cos4=cos(W(4)*t1);
XX=[sin1 cos1 sin2 cos2];

beta=(XX.'*XX)\(XX.'*x1);
plot(t1,XX*beta)
hold off
legend('含有高斯白噪声的谐波信号','不含噪声的谐波信号')
fprintf('信号表达式为%.2fsin(%.2ft)+%.2fcos(%.2ft)+%.2fsin(%.2ft)+%.2fcos(%.2ft)',beta(1),W(1),beta(2),W(1),beta(3),W(2),beta(4),W(2))

