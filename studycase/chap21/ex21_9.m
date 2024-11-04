I = imread('cameraman.tif');
J = uint8(filter2(fspecial('gaussian'), I));
K = imabsdiff(I,J);
subplot(131);imshow(I,[]);
subplot(132);imshow(J,[]);
subplot(133);imshow(K,[]);
