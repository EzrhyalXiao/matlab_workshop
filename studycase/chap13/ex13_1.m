load freqbrk
s=freqbrk;
coefs=cwt(s,[1;30],'morl');
colormap([0 0 0])
mesh(abs(coefs));
