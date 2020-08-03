%% Threshold 적용하기
I = imread('lena.tif');

%im2bw() 함수를 이용한 영상 이진화
BW = im2bw(I, 0.5);
imshowpair(I, BW, 'montage');

[height, width] = size(I);
BW = zeros(height, width);

for y = 1 : height
    for x = 1 : width
        i = I(y, x);
        if i < 128
            i = 0;
        else
            i = 255;
        end
        BW(y, x) = i;
    end
end

imshowpair(I, BW, 'montage');