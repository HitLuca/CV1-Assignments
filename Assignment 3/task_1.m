person_toy = imread('./person_toy/00000001.jpg');
pingpong = imread('./pingpong/0000.jpeg');

kernel_size = 7;
sigma = 1;
threshold = 0.0002;
window_size = 7;

[ix, iy, H, rows_corners, columns_corners] = Harris(person_toy, sigma, kernel_size, threshold, window_size);

figure()
subplot(1, 3, 1);
imshow(ix, []);
subplot(1, 3, 2);
imshow(iy, []);
subplot(1, 3, 3);
imshow(person_toy, []);
hold on;
scatter(columns_corners, rows_corners, '.', 'red')
hold off;

[ix, iy, H, rows_corners, columns_corners] = Harris(pingpong, sigma, kernel_size, threshold, window_size);

figure()
subplot(1, 3, 1);
imshow(ix, []);
subplot(1, 3, 2);
imshow(iy, []);
subplot(1, 3, 3);
imshow(pingpong, []);
hold on;
scatter(columns_corners, rows_corners, '.', 'red')
hold off;