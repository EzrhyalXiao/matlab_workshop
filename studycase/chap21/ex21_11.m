RGB = imread('peppers.png');
M = [0.30, 0.59, 0.11];
gray = imapplymatrix(M, RGB);
figure
subplot(1,2,1), imshow(RGB), title('Original RGB')
subplot(1,2,2), imshow(gray), title('Grayscale Conversion')
