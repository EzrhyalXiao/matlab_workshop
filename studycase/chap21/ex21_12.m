RGB = imread('peppers.png');
RGB2 = imresize(RGB, [64 NaN]);
subplot(1,2,1), imshow(RGB);
subplot(1,2,2), imshow(RGB2);
