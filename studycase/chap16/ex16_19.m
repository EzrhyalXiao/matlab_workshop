figure
subplot(2,2,1)
plot(rand(1,20))
title('grid off')			%参考图20-21左上图
subplot(2,2,2)
plot(rand(1,20))
grid on
title('grid on') 			%参考图20-21右上图
subplot(2,2,[3 4])
plot(rand(1,20))
grid(gca,'minor')
title('grid minor') 			%参考图20-21下图
