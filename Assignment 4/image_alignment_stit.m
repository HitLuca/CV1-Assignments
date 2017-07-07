%% Defining variables
number_match = 10;
iterations = 100;
param_t = 0;        % store the best transformation parameters

%% Preprocessing
image1 = imread('./right.jpg');
image2 = imread('./left.jpg');

image1 = single(rgb2gray(image1));
image2 = single(rgb2gray(image2));

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


%% Image Transformation
image1 = imread('./right.jpg');
image2 = imread('./left.jpg');
[H, W] = size(image1);

[min_x, min_y, max_x, max_y] = find_new_corners(image1, A, t);

new_img = image2;

for u = 1:size(image1, 1)
    for v = 1:size(image1, 2)
        pos = round(A_inv*([v+min_x;u+min_y] - t));
        if pos(1) > 0 && pos(2) > 0 && pos(1) < size(image1, 2) && pos(2) < size(image1, 1)
            new_img(u+min_y, v+min_x, :) = image1(pos(2), pos(1), :);
        end
    end
end

imshow(new_img, [])