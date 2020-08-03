%% Gaussian Kernel Function
function [h] = GaussianKernel(sigma)
    center = int16(3.0 * sigma);
    
    h = zeros([1, 2 * center + 1]);
    [height, width] = size(h);
    
    buff = zeros([1, 2 * center + 1]);
    sigma2 = sigma * sigma;
    
    for i = 1 : width
        r = center - i;
        buff(i) = r^2;
    end
    h = exp(-0.5 * buff / sigma2);
end