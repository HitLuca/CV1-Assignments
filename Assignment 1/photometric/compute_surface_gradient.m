function [ albedo, normal, p, q ] = compute_surface_gradient( stack_images, scriptV )
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   stack_image : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   albedo : the surface albedo
%   normal : the surface normal
%   p : measured value of df / dx
%   q : measured value of df / dy

W = size(stack_images, 1);
H = size(stack_images, 2);

% create arrays for 
%   albedo, normal (3 components)
%   p measured value of df/dx, and
%   q measured value of df/dy
albedo = zeros(W, H);
normal = zeros(W, H, 3);
p = zeros(W, H);
q = zeros(W, H);

% TODO: Your code goes here
% for each point in the image array
for img_w = 1:W
    for img_h = 1:H
        
        %   stack image values into a vector i
        %   construct the diagonal matrix scriptI
        i = reshape(stack_images(img_w, img_h, :), 5, 1);
        scriptI = diag(i);
        
        %   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
        g = pinv(double(scriptI) * double(scriptV)) * (double(i) .^ 2);
        
        %   albedo at this point is |g|
        albedo(img_w, img_h) = norm(g);
        
        %   normal at this point is g / |g|  
        normal(img_w, img_h, :) = g/norm(g);
        
        %   p at this point is N1 / N3
        p(img_w, img_h) = normal(img_w, img_h, 1) / normal(img_w, img_h, 3);
        
        %   q at this point is N2 / N3  
        q(img_w, img_h) = normal(img_w, img_h, 2) / normal(img_w, img_h, 3);
    end
end
end

