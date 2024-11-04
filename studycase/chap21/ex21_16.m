unregistered = imread('westconcordaerial.png');
figure;
subplot(121); imshow(unregistered)
subplot(122);imshow('westconcordorthophoto.png')

load westconcordpoints   	%预设的基准点
t_concord = cp2tform(movingPoints,fixedPoints,'projective');
info = imfinfo('westconcordorthophoto.png');

registered = imtransform(unregistered,t_concord,...
    'XData',[1 info.Width], 'YData',[1 info.Height]);
figure, subplot(121); imshow(registered);
subplot(122); imshow(registered);
hold on
h = imshow(base);
set(h, 'AlphaData', 0.6)
