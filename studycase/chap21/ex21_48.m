I_rgb = imread('peppers.png');
C = makecform('srgb2xyz');
I_xyz = applycform(I_rgb,C);
whos
