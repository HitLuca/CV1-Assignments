function [ height_map ] = construct_surface( p, q, W, H )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measured value of df / dx
%   q : measured value of df / dy
%   W : the width (counting the number of columns) of the height_map
%   H : the height (counting the number of rows) of the height_map
%   height_map: the reconstructed surface

height_map = zeros(W, H);

% TODO: Your code goes here
% top left corner of height_map is zero
% for each pixel in the left column of height_map
%   height_value = previous_height_value + corresponding_q_value

for img_w = 2:W
    height_map(img_w, 1) = height_map(img_w-1, 1) + q(img_w, 1);
end

% TODO: Your code goes here
% for each row
%   for each element of the row except for leftmost
%       height_value = previous_height_value + corresponding_p_value

for img_w = 1:W
    for img_h = 2:H
        height_map(img_w, img_h) = height_map(img_w, img_h-1) + p(img_w, img_h);
    end
end

end

