function [ix, iy, H, rows_corners, columns_corners] = Harris( image, sigma, kernel_size, threshold, window_size)
    %convert the image to grayscale
    image = rgb2gray(image);
    image = checkImageType(image);
    
    %find the gaussian derivatives Ix and Iy
    [ix, iy, ~] = gaussDer(image, sigma, kernel_size); 
    border = (kernel_size-1)/2;
    ix = ix(:, border:end-border-1);
    iy = iy(border:end-border-1, :);
    tmp = ix.*iy;

    %find A, B and C by convolving Ix^2, Iy^2 and Ix*Iy
    A = gaussConv(ix.^2, sigma, kernel_size);
    C = gaussConv(iy.^2, sigma, kernel_size);
    B = gaussConv(tmp, sigma, kernel_size);
    
    %trim the matrices to get same sizes
    A = A(border:end-border-1, border:end-border-1);
    C = C(border:end-border-1, border:end-border-1);
    B = B(border:end-border-1, border:end-border-1);
    
    %calculate H matrix
    H = (A.*C - B.^2) - 0.04 .* ((A + C).^2);

    %find corners
    [rows_corners, columns_corners] = calculateCorners(H, threshold, window_size);
end

function [rows_corners, columns_corners] = calculateCorners(H, threshold, window_size)
    [height, width] = size(H);
    
    border = (window_size-1)/2;
    rows_corners = [];
	columns_corners = [];

    %if an element is the maximum in the nxn window and is above the
    %threshold then is chosen
    for i=1+border:height-border
        for j=1+border:width-border
            if H(i, j) > threshold
                window_max = imregionalmax(H(i-border:i+border, j-border:j+border));
                if window_max(border+1, border+1) == 1
                    rows_corners(end+1) = i;
                    columns_corners(end+1) = j;
                end
            end
        end
    end
end

