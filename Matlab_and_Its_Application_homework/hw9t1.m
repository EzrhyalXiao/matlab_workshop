Fs=4096;
Ts=1/Fs;
L=size(data,1);
t=(0:L-1)*Ts;
x=table2array(data(:,1));
NFFT=2^(nextpow2(Fs));
%NFFT=L;
y=fft(x,NFFT)/L;
f=Fs/NFFT*(0:NFFT-1);
plot(f,abs(y))

mag=abs(y);
mark=[];
mags=[];
for i=1:length(y)
    if abs(y(i))<0.4
        y(i)=0;
    else
        mark=[mark f(i)];
        mags=[mags abs(y(i))];
    end
end

Y=ifft(y*L,NFFT);
mark=mark(1:end/2);
fun1=@(x) cos(2*pi*mark.'.*x);
fun2=@(x) sin(2*pi*mark.'.*x);
XX=[fun1(t);fun2(t)].';
beta=(XX.'*XX)\(XX.'*x);
sins=[];
coss=[];
for i=1:size(beta,1)
    if abs(beta(i))<0.01
        beta(i)=0;
    elseif i>size(beta,1)/2
        coss=[coss mark(i-size(beta,1)/2)];
    else
        sins=[sins mark(i)];
    end
end

bets=beta(52:end)+beta(1:51);
plot(t,XX*beta-x)