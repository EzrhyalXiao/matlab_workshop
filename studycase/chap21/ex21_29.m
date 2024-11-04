I = imread('circuit.tif');
BW1 = edge(I,'prewitt');
BW2 = edge(I,'canny');
subplot(131);imshow(I);
subplot(132);imshow(BW1);
subplot(133);imshow(BW2);
