n = 10:10:60;
r1 = binornd(n,1./n)
r2 = binornd(n,1./n,[1 6])
r3 = binornd(n,1./n,1,6)
r4 = binornd([n; n],[1./n; 1./n],2,6)
