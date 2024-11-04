load noissin; 
whos
c = cwt(noissin,1£º48,'db4');
c1 = cwt(noissin,1£º48,'db4','plot');
c2 = cwt(noissin,2£º2£º128,'db4','plot');
