function output = gaussDer ( image ,G , sigma )
image = checkImageType(image);

kernel_size = size(G, 2);
x = linspace(-kernel_size/2, kernel_size/2, kernel_size);

deriv_filter = -(x/(sigma.^2)) .* G;

new_image = conv2(image, deriv_filter);
output = conv2(new_image, deriv_filter.');

end

