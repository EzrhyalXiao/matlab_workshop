%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%主函数%%%%%%%%%%%%%
clear;
clc;
%%%%%%%%%%%%%输入参数%%%%%%%%%%%%
N=10;               %%城市的个数
M=20;               %%种群的个数
C=100;               %%迭代次数
C_old=C;
m=2;                %%适应值归一化淘汰加速指数
Pc=0.4;             %%交叉概率
Pmutation=0.2;       %%变异概率

%%%%%%%%%生成城市的坐标%%%%%%%%%%%%%%%%
pos=randn(N,2);

%%%%%%%%生成城市之间距离矩阵%%%%%%%%%%%%
D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

%%%%%%%%生成初始群体%%%%%%%%%%%%%%%%%%%%
popm=zeros(M,N);
for i=1:M
    popm(i,:)=randperm(N);
end

%%%%%%%%随机选择一个种群%%%%%%%%%%%%%%%%
R=popm(1,:);
figure(1);
scatter(pos(:,1),pos(:,2) ,'k.');
xlabel('横轴')
ylabel('纵轴')
title('随机产生的种群图')
axis([-3 3 -3 3]);
figure(2);
plot_route(pos,R);      
xlabel('横轴')
ylabel('纵轴')
title('随机生成种群中城市路径情况')
axis([-3 3 -3 3]);

%%%%%%%%初始化种群及其适应函数%%%%%%%%%%%%
fitness=zeros(M,1);
len=zeros(M,1);
for i=1:M
    len(i,1)=myLength(D,popm(i,:));
end
maxlen=max(len);
minlen=min(len);
fitness=fit(len,m,maxlen,minlen);
rr=find(len==minlen);
R=popm(rr(1,1),:);
for i=1:N
fprintf('%d ',R(i));
end
fprintf('\n');
fitness=fitness/sum(fitness); 
distance_min=zeros(C+1,1);  %%各次迭代的最小的种群的距离
while C>=0
fprintf('迭代第%d次\n',C);
%%%%选择操作%%%%
nn=0;
for i=1:size(popm,1)
    len_1(i,1)=myLength(D,popm(i,:));
    jc=rand*0.3;
    for j=1:size(popm,1)
        if fitness(j,1)>=jc
        nn=nn+1;
        popm_sel(nn,:)=popm(j,:);
        break;
        end
    end
end
%%%%每次选择都保存最优的种群%%%%
popm_sel=popm_sel(1:nn,:);
[len_m len_index]=min(len_1);
popm_sel=[popm_sel;popm(len_index,:)]; 
%%%%交叉操作%%%%
nnper=randperm(nn);
A=popm_sel(nnper(1),:);
B=popm_sel(nnper(2),:);
for i=1:nn*Pc
[A,B]=cross(A,B);
popm_sel(nnper(1),:)=A;
popm_sel(nnper(2),:)=B;
end
%%%%变异操作%%%%
for i=1:nn
    pick=rand;
    while pick==0
         pick=rand;
    end
    if pick<=Pmutation
       popm_sel(i,:)=Mutation(popm_sel(i,:));
    end
end
%%%%求适应度函数%%%%
NN=size(popm_sel,1);
len=zeros(NN,1);
for i=1:NN
    len(i,1)=myLength(D,popm_sel(i,:));
end
maxlen=max(len);
minlen=min(len);
distance_min(C+1,1)=minlen;
fitness=fit(len,m,maxlen,minlen);
rr=find(len==minlen);
fprintf('minlen=%d\n',minlen);
R=popm_sel(rr(1,1),:);
for i=1:N
fprintf('%d ',R(i));
end
fprintf('\n');
popm=[];
popm=popm_sel;
C=C-1;
%pause(1);
end
figure(3)
plot_route(pos,R);
xlabel('横轴')
ylabel('纵轴')
title('优化后的种群中城市路径情况')
axis([-3 3 -3 3]);
