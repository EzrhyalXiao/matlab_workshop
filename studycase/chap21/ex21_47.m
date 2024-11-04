RGB1 = imread('autumn.tif');
RGB2 = imread('peppers.png');
X1 = rgb2ind(RGB1,colorcube(128));
X2 = rgb2ind(RGB2,colorcube(128));
subplot(221);imshow(RGB1);
subplot(222);imshow(X1);
subplot(223);imshow(RGB2);
subplot(224);imshow(X2);
