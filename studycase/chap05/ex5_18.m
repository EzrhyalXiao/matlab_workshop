clear all
clc
fplot(@sin,[-2*pi 2*pi])
grid on
title('sin(x) from -2\pi to 2\pi')
xlabel('x');
ylabel('y');