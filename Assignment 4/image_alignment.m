%% Defining variables
number_match = 3;
iterations = 10;
param_t = 0;        % store the best transformation parameters


%% Preprocessing
image1 = imread('./boat1.pgm');
image2 = imread('./boat2.pgm');

image1 = single(image1);
image2 = single(image2);

[f1,d1] = vl_sift(image1);  % f(1:2) center, f(3) scale, f(4) orientation
[f2,d2] = vl_sift(image2);  % d: descriptor

% matches: index of original match, index of the closest descriptor
% scores: distance between the pairs <- check this for inliers
[matches, scores] = vl_ubcmatch(d1, d2);    

%% go into the RANSAC (loop through N times), find transformation param
[A, t, final_inliers] = ransac(iterations, matches, f1, f2, number_match);
A_inv = pinv(A);


%% final parameters
disp(string('final param & inliers'))
A
t
disp(string('final inliners'))
final_inliers
disp(string('total inliners'))
disp(size(matches, 2))


%% matched images
perm = randperm(size(matches,2)) ; % random sampling from the matches
m_ind = perm(1:50) ;     % index for the matches

im1_points = f1(1:2, m_ind);
im2_points = A*im1_points + t + [size(image1, 2); 0];

figure();
image_both = cat(2, image1, image2);
imshow(image_both, [])
hold on;
scatter(im1_points(1, :), im1_points(2, :));
scatter(im2_points(1, :), im2_points(2, :));
h = line([im1_points(1, :) ; im2_points(1, :)], [im1_points(2, :) ; im2_points(2, :)]);
set(h,'linewidth', 1, 'color', 'g') ;
hold off;


%% nearest neighbors interpolation
[H, W] = size(image1);

[min_x, min_y, max_x, max_y] = find_new_corners(image1, A, t);

new_image1 = zeros(max_y, max_x);

for i=1:max_y-min_y
    for j=1:max_x-min_x
        new_coords = round(A_inv * ([j+min_x;i+min_y] - t));
        if new_coords(1) < 1 || new_coords(2) < 1 || new_coords(1) > W || new_coords(2) > H
            new_image1(i, j) = 0;
        else
            new_image1(i, j) = image1(new_coords(2), new_coords(1));
        end
    end
end


%% matlab comparison
x = [A';t'];
transformation = maketform('affine', x);
new_image2 = imtransform(image1, transformation);


%% display the results
figure()
subplot(1, 3, 1);
imshow(new_image1, []);
title('Implementation');
subplot(1, 3, 2);
imshow(new_image2, []);
title('Matlab built-in');
subplot(1, 3, 3);
imshow(image2, []);
title('Reference');