function [] = im2BRG( path )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
im = imread(path);
%imshow(im);
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
imshow(cat(3, B, G, R));
end