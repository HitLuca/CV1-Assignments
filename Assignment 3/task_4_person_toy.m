kernel_size = 7;
sigma = 1;
threshold = 0.0001;
step = 15;
window_size = 7;

root = './person_toy/';
contents = dir(strcat(root, '*.jpg'));
mkdir('person_toy_tracking');

tmp = imread(strcat(root, contents(1).name));

[height, width] = size(rgb2gray(tmp));
outputVideo = VideoWriter(fullfile('person_toy_tracking.avi'));
outputVideo.FrameRate = 20;
open(outputVideo);

%take the first image and find the corners
image1 = imread(strcat(root, contents(1).name));
[ix, iy, H, rows_corners, columns_corners] = Harris(image1, sigma, kernel_size, threshold, window_size);

%iterate through every image and update the position of the corners by
%adding the calculated velocities
for i=2:numel(contents)
    image2 = imread(strcat(root, contents(i).name));
    [u, v] = Regional_Lucas_Kanade(image1, image2, rows_corners, columns_corners, step);

    figure()
    imshow(image1);
    hold on;
    scatter(columns_corners, rows_corners, '.');
    hold on;
    quiver(columns_corners, rows_corners, u, v);
    hold off;
    
    pause(0.2);
    
    s=getframe();
    imwrite(s.cdata, strcat('./person_toy_tracking/', contents(i-1).name));
    
    %add the image to the video only if it has the right size (sometimes
    %the frame has a different size)
    if size(s.cdata, 1) == 572 && size(s.cdata, 2) == 714
        writeVideo(outputVideo, s.cdata);
    end
    close all;
    
    %update the corner coordinate by adding the velocities and rounding the
    %resut to the nearest integer
    image1 = imread(strcat(root, contents(i).name));
    columns_corners = round(columns_corners + u*1.3);
    rows_corners = round(rows_corners + v*1.3);
    
end

close(outputVideo);