function [ ix, iy, Gd ] = gaussDer (image, sigma, kernel_size)

x = linspace(-kernel_size/2, kernel_size/2, kernel_size);

G = gauss(sigma, kernel_size);

Gd = -x.*G ./ (sigma^2);


ix = conv2(image, Gd);
iy = conv2(image, Gd.');
end