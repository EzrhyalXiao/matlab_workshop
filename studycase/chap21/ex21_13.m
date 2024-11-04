X = gpuArray(imread('pout.tif'));
Y = imrotate(X, 37, 'loose', 'bilinear');
subplot(121);imshow(X);
subplot(122);imshow(Y);
