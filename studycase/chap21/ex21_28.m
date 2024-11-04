I = imread('cameraman.tif');
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imhist(I,64)
