I = imread('eight.tif');
J = imnoise(I,'salt & pepper',0.02);
K = medfilt2(J);
subplot(121);imshow(J)
subplot(122);imshow(K)
