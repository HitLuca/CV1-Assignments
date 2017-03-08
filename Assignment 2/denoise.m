function imOut = denoise ( image , kernel_type , kernel_size )
    image = checkImageType(image);
    if strcmp(kernel_type, 'box')
        x = ones(kernel_size) ./ (kernel_size.^2);  % box filter, normalized
        imOut = conv2(image, x);        % convolve the image with box filter
    elseif strcmp(kernel_type, 'median')
        H = size(image, 1);
        W = size(image, 2);
        
        imOut = zeros(H, W);
        l = (kernel_size-1)/2;
        
        for i=l+1:H-l     
            for j=l+1:W-l
                t = image(i-l:i+l, j-l:j+l);  % select part of the image
                imOut(i, j) = median(t(:));   % calculate median of part of image
            end
        end
    end
end

