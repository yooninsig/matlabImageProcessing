I = imread('lena.tif');

%imcomplement( ) 함수를 이용한 영상 반전 실행
bw = imcomplement(I);
imshow(bw);

[height, width] = size(I);
J = zeros(height, width);

for y = 1 : height
    for x = 1 : width
        i = I(y, x);
        b = 255 - i;
        J(y, x) = b;
    end
end

imshowpair(I, J, 'montage');