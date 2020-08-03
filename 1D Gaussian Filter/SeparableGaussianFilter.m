%% SeparableGaussianFilter Function
%% using GaussianKernel Function 1D * 1D
function [outputImage] = SeparableGaussianFilter(input, sigma)
[height, width] = size(input);

mask = GaussianKernel(sigma);
[mheight, mwidth] = size(mask);
filterSize = mwidth;
pad_size = floor(filterSize / 2);

paddedImage = padarray(input, [pad_size, pad_size], 0, 'replicate');
%paddedImage = padarray(paddedImage, [pad_size, pad_size], 0, 'post');
[pad_height, pad_width] = size(paddedImage);

buffImage = zeros(pad_height, pad_width);
outputImage = zeros(mheight, mwidth);

for y = 1 + pad_size : pad_height - pad_size
    for x = 1 + pad_size : pad_width - pad_size
        idx = int16(1);
        sum = 0;
        for hy = y - pad_size : y + pad_size
            sum = sum + uint16(paddedImage(x, hy)) * mask(idx);
            idx = idx + 1;
        end
         buffImage(y - pad_size, x - pad_size ) = sum;
    end
end

buffImage = padarray(buffImage, [pad_size, pad_size], 0, 'replicate');

for y = 1 + pad_size : pad_height - pad_size
    for x = 1 + pad_size : pad_width - pad_size
        idx = int16(1);
        sum = 0;
        for hy = y - pad_size : y + pad_size
            sum = sum + uint16(buffImage(x, hy)) * mask(idx);
            idx = idx + 1;
        end
        outputImage(y - pad_size, x - pad_size) = sum;
    end
end

end