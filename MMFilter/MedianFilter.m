%% 미디언 필터 (Median) 함수 만들기
%% Matlab 함수 제작
function[outputImage] = MedianFilter(inputImage, filterSize)
[image_height, image_width] = size(inputImage);

pad_size = floor(filterSize / 2);
pixels = zeros(filterSize^2, 1);
outputImage = zeros(image_height, image_width);

paddedImage = padarray(inputImage, [pad_size pad_size], 0, 'post');
paddedImage = padarray(paddedImage, [pad_size pad_size], 0, 'pre');

[pad_height, pad_width] = size(paddedImage);

for y = 1 + pad_size : pad_height - pad_size
    for x = 1 + pad_size : pad_width - pad_size
        idx = uint16(1);
        
        for hy = y - pad_size : y + pad_size
            for hx = x - pad_size : x + pad_size
                pixels(idx) = uint16(paddedImage(hy, hx));
                idx = idx + 1;
            end
        end
        sorted_pixels = sort(pixels);
        median_val = median(sorted_pixels);
        outputImage(y - pad_size, x - pad_size) = median_val;
    end
end

end
