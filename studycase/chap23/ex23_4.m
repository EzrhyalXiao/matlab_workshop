clear all
clc
X=0:0.1:2;          	%神经网络输入值
T=cos(X*pi);        	%神经网络目标值
%%%%%绘出此函数上的采样点%%%%
figure(1)
plot(X,T,'+');
title('待逼近的函数样本点');
xlabel('输入值');
ylabel('目标值');
%%%%%建立网络并仿真%%%%%%%%%
n=-4:0.1:4;
a1=radbas(n);
a2=radbas(n-1.5);
a3=radbas(n+2);
a=a1+1*a2+0.5*a3;
figure(2);
plot(n,a1,n,a2,n,a3,n,a,'x');
title('径向基函数的加权和');
xlabel('输入值');
ylabel('输出值');
%径向基函数网络隐含层中每个神经元的权重和阀值指定了相应的径向基函数的位置和宽度。
%每一个线性输出神经元都由这些径向基函数的加权和组成
net=newrb(X,T,0.03,2);  %设置平方和误差参数为0.03            
X1=0:0.01:2;
y=sim(net,X1);       
figure(3);
plot(X1,y,X,T,'+');
title('仿真结果');
xlabel('输入');
ylabel('网络输出及目标输出');
