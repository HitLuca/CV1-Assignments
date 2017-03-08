function [] = im2gayscale( path )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
im = rgb2gray(im2double(imread(path)));
imshow(im);
im1 = im(1:end/2,1:end/2,:);
im2 = im(1:end/2,end/2:end,:);
im3 = im(end/2:end,1:end/2,:);
im4 = im(end/2/end:end/2:end,:);
imshow(im2,im1;im4,im3);
end

