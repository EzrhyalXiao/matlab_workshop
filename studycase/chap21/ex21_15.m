I = imread('cameraman.tif');
tform = maketform('affine',[1 0 0; .5 1 0; 0 0 1]);
J = imtransform(I,tform);
subplot(121);imshow(I);
subplot(122);imshow(J);
