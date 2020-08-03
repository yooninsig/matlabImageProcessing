%% [Correlation Coefficien를 이용한 템플릿 매칭 구현]
%%
clear;
close all;

%% Prepare the image for analysis
F= imread('coins.png'); % read in coins image
T = imread('templateCoin.png'); % read in template image

%% display frame and template
figure, subplot(121), imshow(F), title('Gray Coins Image');
subplot(122), imshow(T), title('Coin Template');

%% correlation matching
[corrScore, boundingBox] = corrMatching(F, T);

%% show results
figure, imagesc(abs (corrScore)), axis image, axis off, colorbar,
title('Corr Measurement Space');
bY = [boundingBox(1), boundingBox(1) + boundingBox(3), boundingBox(1) + boundingBox(3), boundingBox(1), boundingBox(1)];
bX = [boundingBox(2), boundingBox(2), boundingBox(2) + boundingBox(4), boundingBox(2) + boundingBox(4), boundingBox(2)];
figure, imshow(F), line(bX, bY), title('Detected Area');