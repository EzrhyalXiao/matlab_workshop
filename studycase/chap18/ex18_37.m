clear all
clc
M = gallery('integerdata', 100, [5 8], 0); 
dlmwrite('myfile.txt', M, 'delimiter', '\t')
m1=dlmread('myfile.txt')
m2=dlmread('myfile.txt', '\t', 2, 3)
m3=dlmread('myfile.txt', '\t', 'C1..G4')
