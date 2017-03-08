function [ scriptV ] = get_source(scale_factor)
%GET_SOURCE compute illumination source property 
%   scale_factor : arbitrary 

if nargin == 0
    scale_factor = 1;
end
%scriptV = 0;

% TODO: define arbitrary direction to V
v1 = [0, 0, 1];
v2 = [-1, 1, 1];
v3 = [1, 1, 1];
v4 = [-1, -1, 1];
v5 = [1, -1, 1];

% TODO: normalize V into scriptV

scriptV = [
    v1/norm(v1);
    v2/norm(v2);
    v3/norm(v3);
    v4/norm(v4);
    v5/norm(v5);
    ];

% scale up to scale factor before return
scriptV = scale_factor * scriptV;

end

