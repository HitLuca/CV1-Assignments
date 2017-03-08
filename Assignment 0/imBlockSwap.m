function [] = imBlockSwap( path )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
im = imread(path);
%imshow(im);
im1 = im(1:end/2,1:end/2,:);
im2 = im(1:end/2,(end/2)+1:end,:);
im3 = im((end/2)+1:end,1:end/2,:);
im4 = im((end/2)+1:end,(end/2)+1:end,:);
imshow([im2,im1;im4,im3]);
end

