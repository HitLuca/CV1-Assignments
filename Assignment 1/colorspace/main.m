% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');
ConvertColorSpace(I,'opponent');

% close all
ConvertColorSpace(I,'rgb');

% close all
ConvertColorSpace(I,'hsv');

% close all
ConvertColorSpace(I,'ycbcr');

% close all
ConvertColorSpace(I,'gray');