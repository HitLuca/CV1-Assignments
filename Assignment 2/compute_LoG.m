function imOut = compute_LoG (image, LOG_type)
image = checkImageType(image);
laplacian_kernel = [0 -1 0; -1 4 -1; 0 -1 0];
kernel_size = 3;
sigma = 0.5;
sigma1 = 10;

if LOG_type == 1    
    % applying a Gaussian kernel, then laplacian
    imOut = gaussConv( image , sigma , sigma , kernel_size);
    imOut = conv2(imOut, laplacian_kernel);

elseif LOG_type == 2
    % applying Laplacian kernel without Gaussian
    imOut = conv2(image, laplacian_kernel);
    
elseif LOG_type == 3
    % filter two images with different value of sigma
    new_image1 = gaussConv( image , sigma , sigma , kernel_size);
    new_image2 = gaussConv( image , sigma1 , sigma1 , kernel_size);
    
    % find the difference between them to approximate the Laplacian
    imOut = new_image2 - new_image1;
end
end

