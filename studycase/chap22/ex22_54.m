tc = gauspuls('cutoff',50e3,0.6,[],-40); 
t = -tc : 1e-6 : tc; 
yi = gauspuls(t,50e3,0.6); 
plot(t,yi)
