function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
    output_image = zeros(size(input_image));
    d = input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3);
    output_image(:,:,1) = input_image(:,:,1) ./ d;
    output_image(:,:,2) = input_image(:,:,2) ./ d;
    output_image(:,:,3) = input_image(:,:,3) ./ d;
end

