[b,a] = butter(5,0.5);
[h,w] = freqz(b,a,64);
[b4,a4] = invfreqz(h,w,4,4);
fvtool(b,a,b4,a4)
legend('Original Magnitude','Estimated Magnitude');
