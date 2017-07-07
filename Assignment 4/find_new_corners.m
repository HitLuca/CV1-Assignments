function [min_x, min_y, max_x, max_y] = find_new_corners(image1, A, t)  
    [H, W] = size(image1);

    min_x = -1;
    min_y = -1;
    max_x = -1;
    max_y = -1;

    new_coords = transform_coordinates([1;1], A, t);
    [min_x, min_y, max_x, max_y] = check_coordinates(min_x, min_y, max_x, max_y, new_coords);

    new_coords = transform_coordinates([1;H], A, t);
    [min_x, min_y, max_x, max_y] = check_coordinates(min_x, min_y, max_x, max_y, new_coords);

    new_coords = transform_coordinates([W;1], A, t);
    [min_x, min_y, max_x, max_y] = check_coordinates(min_x, min_y, max_x, max_y, new_coords);

    new_coords = transform_coordinates([W;H], A, t);
    [min_x, min_y, max_x, max_y] = check_coordinates(min_x, min_y, max_x, max_y, new_coords);
end

function [min_x, min_y, max_x, max_y] = check_coordinates(min_x, min_y, max_x, max_y, coord)
    if min_x == -1
        min_x = coord(1);
        max_x = coord(1);
        min_y = coord(2);
        max_y = coord(2);
    else
        if min_x > coord(1)
            min_x = coord(1);
        end
        if max_x < coord(1)
            max_x = coord(1);
        end
        if min_y > coord(2)
            min_y = coord(2);
        end
        if max_y < coord(2)
            max_y = coord(2);
        end
    end
end

function [new_coords] = transform_coordinates(coord, A, t)
    new_coords = round(A * coord + t);
end

