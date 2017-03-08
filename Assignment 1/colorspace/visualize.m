function visualize(input_image, colorspace)
    grayscales = {'lightness' 'average' 'luminosity' 'matlab'};
    
    figure('Name', colorspace, 'NumberTitle', 'off')
    if size(input_image, 3) == 4
        for i=1:4
            subplot(2, 2, i);
            imshow(input_image(:,:,i))
            title(grayscales(i))
        end
    else
        %creation of a red-only image, green-only image, blue-only image
        a = zeros(size(input_image, 1), size(input_image, 2));
        red = cat(3, input_image(:,:,1), a, a);
        green = cat(3, a, input_image(:,:,2), a);
        blue = cat(3, a, a, input_image(:,:,3));
        
        %display of the images
        subplot(2, 2, 1);
        imshow(red)
        title('R')
        
        subplot(2, 2, 2);
        imshow(green)
        title('G')
        
        subplot(2, 2, 3);
        imshow(blue)
        title('B')
        
        subplot(2, 2, 4);
        imshow(input_image(:,:,:))
        title('combined')
    end
end

