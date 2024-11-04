t = 0 : 1/1e3 : 1; 
d = [0.1 0.4 0.6 0.9]'; 
y = pulstran(t,d,'tripuls',0.1,0);
d1=[0 : 1/1E1 : 1 ; 0.7.^(0:10)]';
y1 = pulstran(t,d1,'gauspuls',10e3,0.5);
subplot(211);
plot(t,y)
axis tight
subplot(212);
plot(t,y1)
axis tight
