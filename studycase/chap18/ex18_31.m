clear all
clc
M1=csvread('txtlist.dat')
M2=csvread('txtlist.dat',2,0)
M3=csvread('txtlist.dat',2,0,[2,0,3,3])
