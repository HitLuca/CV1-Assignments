function [ imOut ] = checkImageType( image )
if isa(image, 'uint8')
    imOut = im2double(image);
else
    imOut = image;
end
end

