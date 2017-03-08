function [ output ] = gaussConv( image , sigma_x , sigma_y , kernel_size )
image = checkImageType(image);

filter1 = gauss(sigma_x, kernel_size);

filter2 = gauss(sigma_y, kernel_size);

new_image = conv2(image, filter1);
output = conv2(new_image, filter2.');

end

