%%%%%%建立一个感知器神经网络%%%%%%%%%
clear all
clc
x = [0 1 0 1; 0 0 1 1];
t = [0 0 0 1];
net = perceptron;
net = configure(net,x,t);
net.iw{1,1}
net.b{1}
%%%%%%训练所建立的神经网络%%%%%%
net = train(net,x,t);
net.iw{1,1}
net.b{1}
%%%%%%初始化训练后的感知器神经网络%%%%%
net = init(net);
net.iw{1,1}
net.b{1}
