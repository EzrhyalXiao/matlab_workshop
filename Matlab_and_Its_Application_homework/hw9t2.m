n=linspace(0,1,1000);
%n=1:1:1000;
fh=[1209,1336,1477,1633];
fl=[697,770,852,941];
anjian=zeros(9,1100);

kong=zeros(1,100);
for i=1:9
    anjian(i,:)=[sin(2*pi*fh(i+3-3*ceil(i/3))*n)+sin(2*pi*fl(ceil(i/3))*n),kong];
end
sy=[];
for i=1:9
    sy=[sy,anjian(i,:)];
end

sound(sy)


function[shuzi]=shibie(xinghao)
fh=[1209,1336,1477,1633];
fl=[697,770,852,941];
n=size(xinghao,2);
num=n/1100;
pianduan=zeros(num,1100);
for i=1:num
    pianduan(i,:)=xinghao(1+(i-1)*1100:1+i*1100);
end
shuzi=zeros(num,1);
for i=1:num
    YR1024=abs(fft(pianduan(1:1024),1024));
    [~,i]=sort(YR1024(1:512));

end

end