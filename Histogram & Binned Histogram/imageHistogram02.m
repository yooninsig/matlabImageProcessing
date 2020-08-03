%% matlab 영상의 히스토 그램 분석

I = imread('lena.tif');

[height, width] = size(I);

H = zeros([256, 1]);

for y = 1 : height
    for x = 1 : width
        i = I(y, x);
        H(i + 1) = H(i + 1) + 1;
    end
end