function G = gauss(sigma , kernel_size)
x = linspace(-(kernel_size-1)/2, (kernel_size-1)/2, kernel_size);
G = 1/(sigma * sqrt(2*pi)) * exp(-x.^2/(2*sigma^2));
G = G ./ sum(G);
end