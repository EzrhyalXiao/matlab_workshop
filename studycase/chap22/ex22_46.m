n=150;
f=[0 0.3 0.7 1];
a=[1 0 1];
up=[1.02 0.01 1.02];
lo =[0.98 -0.01 0.98];
b = fircls(n,f,a,up,lo,'both');
freqz(b)
