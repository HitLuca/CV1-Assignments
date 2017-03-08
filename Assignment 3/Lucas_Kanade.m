function [ u_arrow, v_arrow ] = Lucas_Kanade(image1, image2, step)
    bw_image1 = checkImage(image1);
    bw_image2 = checkImage(image2);
    
    border = (step-1)/2;
    [H, W] = size(bw_image1);
    
    %find gradients and time derivative
    [ix, iy] = gradient(bw_image1);
    it = bw_image2 - bw_image1;
    
	u_arrow = zeros(floor(H/step), floor(W/step));
    v_arrow = zeros(size(u_arrow));

    %iterate through every window and find the corresponding velocity
    %vector
    for i=border+1:step:H-border
        for j=border+1:step:W-border
            temp_x = ix(i-border:i+border, j-border:j+border);
            temp_y = iy(i-border:i+border, j-border:j+border);
            temp_t = it(i-border:i+border, j-border:j+border);
            
            A = [reshape(temp_x, 1, numel(temp_x)); reshape(temp_y, 1, numel(temp_y))]';
            b = reshape(-temp_t, 1, numel(temp_t))';
            
            v = pinv(A' * A)*A'*b;
            
            index_i = floor(i/step)+1;
            index_j = floor(j/step)+1;

            u_arrow(index_i, index_j) = v(1);
            v_arrow(index_i, index_j) = v(2);
        end
    end
end

function [bw_image] = checkImage(image)
    bw_image = image;
    if size(image, 3) == 3
        bw_image = rgb2gray(image);       
    end
    bw_image = checkImageType(bw_image);
end

