%% lena 이미지의 히스토그램을 비닝(Binning)하여 수정하기

I = imread('lena.tif');

[height, width] = size(I);

K = 256;
B = 32;

H = zeros([B, 1]);

for y = 1 : height
    for x = 1 : width
        a = double(I(x, y));
        i = uint8((a * B) / K);
        H(i + 1) = H(i + 1) + 1;
    end
end