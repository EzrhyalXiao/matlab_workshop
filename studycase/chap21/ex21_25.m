clc,clear all,close all; 
I=imread('pout.tif'); 
figure,imshow(I);
x = [19 427 416 77];
y = [96 462 37 33];
figure,improfile(I,x,y),grid on;
