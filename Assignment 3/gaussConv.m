function imOut = gaussConv(image, sigma_x, kernel_size)

filter = gauss(sigma_x, kernel_size);
filter = filter ./ sum(filter);

image = conv2(image, filter);
imOut = conv2(image, filter.');

end
