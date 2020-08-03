%% 평균 값 (mean) 필터 함수 만들기
%% matlab 함수 제작

function[outputImage] = MeanFilter(inputImage, filterSize)

[height, width] = size(inputImage);

pad_size = floor(filterSize / 2);
outputImage = zeros(height, width);

paddedImage = padarray(inputImage, [pad_size pad_size], 0, 'post');
paddedImage = padarray(paddedImage, [pad_size pad_size], 0, 'pre');
[pad_height, pad_width] = size(paddedImage);

for y = 1 + pad_size : pad_height - pad_size
    for x = 1 + pad_size : pad_width - pad_size
        s = uint16(0);
        
        for hy = y - pad_size : y + pad_size
            for hx = x - pad_size : x + pad_size
                s = s + uint16(paddedImage(hy, hx));
            end
        end
        
        outputImage(y - pad_size, x - pad_size) = floor(s/(filterSize^2));
    end
end

end