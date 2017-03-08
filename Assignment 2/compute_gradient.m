function [ im_magnitude , im_direction ] = compute_gradient( image )
    % sobel kernels
    x = [-1 0 1; -2 0 2; -1 0 1];
    y = [1 2 1; 0 0 0; -1 -2 -1];

    % get the gradient by convolving the image with both x and y sobel kernels
    Gx = conv2(x, image);
	Gy = conv2(image, y);
    
    % find gradient magnitude and direction
    im_magnitude = sqrt(Gx.^2+Gy.^2);
    im_direction = atan2(Gy,Gx); %(atan(Gy ./ Gx)+pi/2)*180/pi;

    subplot(2, 2, 1);
    imshow(Gx, []);
    title('Gx');
    
    subplot(2, 2, 2);
    imshow(Gy, []);
    title('Gy');
    
    subplot(2, 2, 3);
    imshow(im_magnitude, []);
    title('Magnitude');
    
    subplot(2, 2, 4);
    imshow(im_direction, []);
    title('Direction');
end