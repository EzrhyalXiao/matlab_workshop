RGB = imread('peppers.png');
I = rgb2gray(RGB);
J = dct2(I);
subplot(221);imshow(RGB);
subplot(222);imshow(I);
subplot(223); imshow(log(abs(J)),[]), colormap(jet(64)), colorbar
J(abs(J) < 10) = 0;
K = idct2(J);
subplot(224);imshow(K,[0 255])
