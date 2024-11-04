t = (0:1/1023:1);
x = sin(2*pi*60*t);
y = hilbert(x);
plot(t(1:50),real(y(1:50))), hold on
plot(t(1:50),imag(y(1:50)),':');
axis([0 0.05 -1.1 2]);
legend('Real Part','Imaginary Part','location','northeast')
