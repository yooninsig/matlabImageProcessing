%% 제작한 Filter 함수 실행 공간
L = imread('lenna-saltandpepper.tif');
F = MedianFilter(L, 3);
imshowpair(L, F, 'montage');
