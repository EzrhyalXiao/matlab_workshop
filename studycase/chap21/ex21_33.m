I = imread('pout.tif');
J = imadjust(I);
subplot(221);imshow(I)
subplot(223);imhist(I,64)
subplot(222);imshow(J)
subplot(224);imhist(J,64)
