I = imread('peppers.png');
J = imcrop(I,[75 68 130 112]);
subplot(121);imshow(I);
subplot(122);imshow(J);
