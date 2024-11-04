originalBW = imread('circles.png');  
se = strel('disk',11);        
erodedBW = imerode(originalBW,se);
subplot(121);imshow(originalBW)
subplot(122);imshow(erodedBW)
