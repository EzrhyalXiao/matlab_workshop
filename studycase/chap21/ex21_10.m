I = imread('glass.png');
J = imcomplement(I);
subplot(121);imshow(I);
subplot(122);imshow(J);
