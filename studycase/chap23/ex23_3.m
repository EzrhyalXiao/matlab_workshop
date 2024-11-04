clear all
clc
P = {1 2 1 3 3 2};
Pi = {1 3};
T = {5.0 6.1 4.0 6.0 6.9 8.0};
net = newlind(P,T,Pi);        %根据设置的参数，建立线性神经网络
Y = sim(net,P,Pi)             %检测上一步建立的神经网络性能
