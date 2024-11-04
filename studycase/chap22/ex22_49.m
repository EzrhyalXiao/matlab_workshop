randn('state',0);
noise = randn(50000,1);  
x = filter(1,[1 1/2 1/3 1/4],noise);
x = x(45904:50000);
[b,a] = prony (x,3,3);
est_x = filter(b,a,x);
e = x - est_x; 
[acs,lags] = xcorr(e,'coeff');
subplot(121)
plot(1:97,x(4001:4097),1:97,est_x(4001:4097),'--');
title('Original Signal vs. ARMA model');
xlabel('Sample Number'); ylabel('Amplitude'); grid;
legend('Original Signal',' ARMA model ')
subplot(122)
plot(lags,acs); 
title('Autocorrelation of the Prediction Error');
xlabel('Lags'); ylabel('Normalized Value'); grid;
