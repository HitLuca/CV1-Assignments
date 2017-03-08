function [ u_arrow, v_arrow ] = Regional_Lucas_Kanade(image1, image2, rows_corners, columns_corners, step)
    %implementation of Lucas_Kanade with given corner coordinates
    bw_image1 = checkImage(image1);
    bw_image2 = checkImage(image2);
  
    border = (step-1)/2;
    [ix, iy] = gradient(bw_image2);
    it = bw_image2 - bw_image1;
    
	u_arrow = zeros(1, numel(rows_corners));
    v_arrow = zeros(size(u_arrow));
    
    %iterate through every corner and find the velocity vectors from the
    %window centered in the corner
    for k=1:numel(rows_corners)
        i = rows_corners(k);
        j = columns_corners(k);
        
        i_min = max(1, i-border);
        j_min = max(1, j-border);
        i_max = min(size(ix, 1), i+border);
        j_max = min(size(ix, 2), j+border);
        
        temp_x = ix(i_min:i_max, j_min:j_max);
        temp_y = iy(i_min:i_max, j_min:j_max);
        temp_t = it(i_min:i_max, j_min:j_max);
        
        A = [reshape(temp_x, 1, numel(temp_x)); reshape(temp_y, 1, numel(temp_y))]';
        b = reshape(-temp_t, 1, numel(temp_t))';
        
        v = pinv(A' * A)*A'*b;

        u_arrow(k) = v(1);
        v_arrow(k) = v(2);
    end   
end

function [bw_image] = checkImage(image)
    bw_image = image;
    if size(image, 3) == 3
        bw_image = rgb2gray(image);       
    end
    bw_image = checkImageType(bw_image);
end

