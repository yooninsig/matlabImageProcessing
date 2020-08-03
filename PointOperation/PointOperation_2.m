I = imread('lena.tif');
[height, width] = size(I);

subplot(1, 2, 1);
imshow(I);

for y = 1 : height
    for x = 1 : width
        i = double(I(y, x));
        a = i + 100;
        
        if a < 0
            i = 0;
        end
        if a> 255
            i = 255;
        end
        I(y, x) = uint8(a);
    end
end

subplot(1, 2, 2);
imshow(I);