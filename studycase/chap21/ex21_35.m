I = imread('pout.tif');
[J,T] = histeq(I);
subplot(221);imshow(I)
subplot(222);imshow(J)
subplot(223); plot((0:255)/255,T)
subplot(224);imhist(J,64)
