I = imread('cameraman.tif');
J = imadjust(I,[0 0.2],[0.5 1]);
subplot(221);imshow(I)
subplot(223);imhist(I,64)
subplot(222);imshow(J)
subplot(224);imhist(J,64)
