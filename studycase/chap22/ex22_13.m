x1=[2 0.5 0.9 1, 0.7 -0.6 0.1 -1.7];
x=fliplr(x1);
subplot(211);
stem(0:length(x1)-1,x1)
axis([-1 length(x1) -2 2] )
subplot(212);
stem(0:length(x)-1,x)
axis([-1 length(x) -2 2] )
