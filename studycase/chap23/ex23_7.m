clear all
clc
% 定义训练样本变量 
% P 为输入变量 
P = [-1:0.05:1]; 
% T 为目标变量 
%randn('seed',78341223); 
T = sin(2*pi*P)+0.1*randn(size(P)); 
%绘制样本数据点
figure(1)
plot(P,T,'+'); 
title('绘制样本数据点');
xlabel('输入变量');
ylabel('目标变量'); 
hold on; 
%  绘制不含噪声的正弦曲线
figure(2)
plot(P,sin(2*pi*P),':');     
title('绘制不含噪声的数据点');
xlabel('输入变量');
ylabel('不含噪声的数据点'); 
hold on
%  创建一个新的前向神经网络 
net=newff(minmax(P),[20,1],{'tansig','purelin'}); 
%  采用 L-M 优化算法 TRAINLM 
net.trainFcn='trainlm';            
%  设置训练参数         
net.trainParam.epochs = 200;         
net.trainParam.goal = 1e-6;  
% 重新初始化  
net=init(net);               
%  调用相应算法训练 BP 网络 
[net,tr]=train(net,P,T); 
%  对 BP 网络进行仿真 
A = sim(net,P); 
%  计算仿真误差 
E = T - A; 
MSE=mse(E) 
%  绘制匹配结果曲线 
figure(3)
plot(P,A,P,T,'+'); 
title('仿真结果比较');
xlabel('输入变量');
ylabel('仿真误差和目标变量'); 
hold on
MSE