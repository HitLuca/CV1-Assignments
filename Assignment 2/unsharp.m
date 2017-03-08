function imOut = unsharp (image, sigma, kernel_size, k)
image = checkImageType(image);

% create a low-passed image with Gaussian filter
new_image = gaussConv(image, sigma, sigma, kernel_size);

H = size(new_image, 1) - size(image, 1);
W = size(new_image, 2) - size(image, 2);

%subplot(2, 2, 1);
figure()
imshow(image);


new_image = new_image(1+H/2:size(new_image, 1)-H/2, 1+W/2:size(new_image, 2)-W/2);

%subplot(2, 2, 2);
figure()
imshow(new_image);

%subplot(2, 2, 3);
figure()

% get the high-passed image by subtracting low-passed image from the
% original image
new_image = (image - new_image) * k;
imshow(new_image);

%subplot(2, 2, 4);
figure()

% add the original image to create an enhanced image
new_image = new_image + image;
imshow(new_image);

imOut = new_image;
end