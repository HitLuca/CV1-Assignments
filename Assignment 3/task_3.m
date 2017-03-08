sphere1 = imread('./sphere1.ppm');
sphere2 = imread('./sphere2.ppm');

synth1 = imread('./synth1.pgm');
synth2 = imread('./synth2.pgm');

sigma = 0.8;
kernel_size = 5;
step = 15;
border = (step-1)/2;
[H, W] = size(sphere1(:,:,1));
[x, y] = meshgrid(border+1:step:W, border+1:step:H);
[u, v] = Lucas_Kanade(sphere1, sphere2, step);

figure(1)
imshow(sphere1);
hold on;
quiver(x, y, u, v);
hold off;

[H, W] = size(synth1);
[x, y] = meshgrid(border+1:step:W-1, border+1:step:H-1);
[u, v] = Lucas_Kanade(synth1, synth2, step);

figure(2)
imshow(synth1);
hold on;
quiver(x, y, u, v);
