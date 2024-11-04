RGB = imread('saturn.png');
I = rgb2gray(RGB);
subplot(131);imshow(I)
J = imnoise(I,'gaussian',0,0.025);
subplot(132);imshow(J)
K = wiener2(J,[5 5]);
subplot(133);imshow(K)
