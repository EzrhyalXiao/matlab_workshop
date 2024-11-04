originalRGB = imread('peppers.png');
subplot(121);imshow(originalRGB)
h = fspecial('motion', 50, 45);
filteredRGB = imfilter(originalRGB, h);
subplot(122);imshow(filteredRGB)
