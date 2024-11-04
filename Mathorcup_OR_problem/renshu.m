data0=readcell('附件1：车站数据.xlsx');
data1=readmatrix('附件2：区间运行时间.xlsx');
data2=readmatrix('附件3：OD客流数据.xlsx');
data3=readmatrix('附件4：断面客流数据.xlsx');


numbersum=27;
a=8;b=17;
m=3;
wei=0;
Q=string(data0(2:31,2))== "是";
time=data1(:,2);
len=data1(:,3);
OD=data2(:,2:31);
J=data3(:,2);
[~,max_position]=max(J);

sumtime=zeros(1,31);
wanle=zeros(1,31);
%for j=1:31
j=26;
X=zeros(30,numbersum);
SX=zeros(30,numbersum);
new_od=OD;
%[new_od,SX(:,1),X(:,1)]=yunshu(1860,a,b,new_od);
for i=1:numbersum
    if mod(i,m)==wei
        [new_od,SX(:,i),X(:,i)]=yunshu(1860,a,b,new_od,j+89);
    else
        [new_od,SX(:,i),X(:,i)]=yunshu(1860,1,30,new_od,j+89);
    end
end
%[new_od,SX(:,numbersum-1),X(:,numbersum-1)]=yunshu(1860,1,30,new_od);
%[new_od,SX(:,numbersum),X(:,numbersum)]=yunshu(1860,1,30,new_od);

twait=max(max(SX.')*0.04,20);
T_min=max(twait)+108;
t1=sum(time(1:7))+sum(twait(1:7));
T=t1/floor(t1/T_min);
ZHANTAI=ZTF(twait,time,T,numbersum,m,a,b,wei);
timexiache=ZHANTAI(2:2:end,:);
timeshangche=ZHANTAI(1:2:end,:);
sumtime(1,j)=sum(sum(timexiache.*X(2:end,:)))/sum(sum(X));
wanle(j)=(max(max(new_od))==0);
%end


S=SX-X;
%sumtimeshangche=sum(sum(timeshangche.*S(1:end-1,:)))/sum(sum(X));
%yunxi=sumtime-sumtimeshangche;
disp(sumtime)
%disp(yunxi)
ZT=shuchu(ZHANTAI);












function[ZHANTAI]=ZTF(twait,time,T,n,m,a,b,wei)
timecost=[twait ;[time.' 0]];
zhanshu=length(twait);
ZHANTAI=zeros(zhanshu*2-2,n);
for i=1:n
    if mod(i,m)==wei
        ZHANTAI(2*a-1,i)=T*(i-1)+timecost(2*a-1);
        for j=2*a:2*b-1
            ZHANTAI(j,i)=ZHANTAI(j-1,i)+timecost(j);
        end
    else
        ZHANTAI(1,i)=T*(i-1)+timecost(1);
        for j=2:zhanshu*2-2
            ZHANTAI(j,i)=ZHANTAI(j-1,i)+timecost(j);
        end
    end
end
end



function[ZT]=shuchu(ZHANTAI)
n=size(ZHANTAI,2);
m=size(ZHANTAI,1);
ZT=string(zeros(m,n));
for i=1:m
    for j=1:n
    if ZHANTAI(i,j)>0
        ts=ZHANTAI(i,j);
        H=floor(ts/3600);
        M=floor((ts-H*3600)/60);
        S=floor(ts-H*3600-M*60);
        if M<10
            str2=strcat('0',string(M));
        else
            str2=string(M);
        end
        if S<10
            str3=strcat('0',string(S));
        else
            str3=string(S);
        end
        date=strcat(string(H+7),':',str2,':',str3);
        ZT(i,j)=date;
    end
    end
end
%xlswrite('C:\Users\ASUS\Desktop\dataZT.xlsx',ZT);
end




function[new_od,SX,X,path]=yunshu(rong,a,b,od,timax)
M=od;
n=size(M,1);
S=zeros(n,1);
X=zeros(n,1);
renshu=0;
path=zeros(n,n);
for i=a:b-1
    X(i)=sum(path(1:i-1,i));
    renshu=renshu-X(i);
    k=1;
    time=X(i)*0.04;
    while renshu<rong && i+k<=n && time<timax
        if renshu+M(i,i+k)<=rong && time+M(i,i+k)*0.04<timax
            path(i,i+k)=M(i,i+k);
        else
            path(i,i+k)=min(rong-renshu,(timax-time)/0.04);
        end
        time=time+path(i,i+k)*0.04;
        renshu=renshu+path(i,i+k);
        k=k+1;
    end
    S(i)=sum(path(i,i:end));
end
if b==size(od,1)
    X(b)=sum(path(1:b-1,b));
    SX=S+X;
    new_od=od-path;
else
    X(b)=renshu;
    SX=S+X;
    new_od=od-path;
    for j=b+1:size(od,1)
        new_od(b,j)=new_od(b,j)+sum(path(1:b-1,j));
    end
end
end




function[new_od,SX,X,path]=yunshu2(rong,a,b,od)
M=od;
timax=115;
n=size(M,1);
S=zeros(n,1);
X=zeros(n,1);
renshu=0;
path=zeros(n,n);
for i=a:b-1
    X(i)=sum(path(1:i-1,i));
    renshu=renshu-X(i);
    time=X(i)*0.04;
   if sum(M(i,i+1:end))+renshu<=rong && time+0.04*sum(M(i,i+1:end))<=timax
       path(i,i:end)=M(i,i:end);
   else
       path(i,i:end)=M(i,i:end)/sum(M(i,i:end))*min(rong-renshu,(timax-time)/0.04);
   end
   S(i)=sum(path(i,i:end));
   renshu=renshu+S(i);
end
if b==size(od,1)
    X(b)=sum(path(1:b-1,b));
    SX=S+X;
    new_od=od-path;
else
    X(b)=sum(path(1:b-1,b));
    SX=S+X;
    new_od=od-path;
    for j=b+1:size(od,1)
        new_od(b,j)=new_od(b,j)+sum(path(1:b-1,j));
    end
end
end