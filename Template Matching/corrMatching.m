%% [Correlation Coefficien를 이용한 템플릿 매칭 구현]
%%

function [corrScore, boundingBox] = corrMatching(frameImg, templateImg, threshC)
%% 1. initialization
if size(frameImg, 3) ~= 1
    frameGray = rgb2gray(frameImg);
else
    frameGray = frameImg;
end
frameGray = double(frameGray);
if size(templateImg, 3) ~= 1
    templateGray = rgb2gray(templateImg);
else
    templateGray = templateImg;
end
templateGray = double(templateGray);
[templateHeight, templateWidth] = size(templateGray);

%% 2. correlation calculation
K = numel(templateGray);
frameMean = conv2(frameGray, ones(size(templateGray))./ K, 'same');
templateMean = mean(templateGray(: ));
corrPartl = conv2(frameGray, templateGray, 'same') ./ K;
corrPartll = frameMean.* templateMean;
stdFrame = sqrt(conv2(frameGray.^2, ones(size(templateGray))./ K, 'same') - frameMean.^2);
stdTemplate = std(templateGray(:));
corrScore = (corrPartl - corrPartll) ./ (stdFrame.* stdTemplate);

%% 3. finding most likely region
[maxVal, maxIdx] = max(corrScore(:));
[maxR, maxC] = ind2sub([size(corrScore, 1), size(corrScore, 2)], maxIdx);

%% 4. hypothesis test
if ~exist('threshC', 'var')
    threshC = .75;
end
if maxVal >= threshC
    boundingBox(1, :) = [max(1, maxR - round(templateHeight /2)), max(1, maxC-round(templateWidth / 2)), templateHeight, templateWidth];
else
    boundingBox(1, :) = [];
end


end