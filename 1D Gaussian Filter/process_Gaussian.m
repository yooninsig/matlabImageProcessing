I = imread('lena.tif');
G = SeparableGaussianFilter(I, 7.0);

subplot(1, 2, 1);
imshow(I);
subplot(1, 2, 2);
imshow(G, []);

