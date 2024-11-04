%读入信号
load detfingr
%求颜色索引表长度
nbc=size(map,1);
%得到信号的阈值，保留层数，小波树优化标准
[thr,sorh,keepapp,crit]=ddencmp('cmp','wp',X)
%通过以上得到的参数对信号进行压缩
[xd,treed,perf0,perfl2]=wpdencmp(X,sorh,4,'sym4',crit,thr*2,keepapp);
%更改索引表为pink索引表
colormap(pink(nbc));
subplot(121);image(wcodemat(X,nbc));title('原始图像');
subplot(122);image(wcodemat(xd,nbc));title('全局阈值化压缩图像');
xlabel(['能量成分',num2str(perfl2),'%',
…'零系数成分',num2str(perf0),'%']);
plot(treed);
