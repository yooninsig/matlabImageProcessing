clear;
close all;
clc;

figure1 = figure;
ax1 = axes('Parent', figure1);
ax2 = axes('Parent', figure1);
set(ax1, 'Visible', 'off');
set(ax2, 'Visible', 'off');

%% 영상 수집하기
fabric = imread('cBeach.tif');
imshow(fabric)
title('Fabric')

%% 각 영역의 샘플 색을 L * a * b 컬러스페이스로 계산하기
load regioncoordinates;

nColors = 6;
sample_regions = false([size(fabric, 1) size(fabric, 2) nColors]);

for count = 1 : nColors
    sample_regions(:, :, count) = roipoly(fabric, region_coordinate(:, 1, count), region_coordinates(:, 2, count));
    
I = imshow(sample_regions(:, :, count), 'Parent', ax2);
set(I, 'AlphaData', 0.5);
imshow(fabric, 'Parent', ax1);
end

lab_fabric = rgb2lab(fabric);

a = lab_fabric(:, :, 2);
b = lab_fabric(:, :, 3);
color_markers = zeros([nColors, 2]);

for count = 1 : nColors
    color_markers(count, 1) = mean2(a(sample_regions(:, :, count)));
    color_markers(count, 2) = mean2(b(sample_regions(:, :, count)));
end

%% 최근접이웃 규칙을 사용하여 각 픽셀 분류하기

color_labels = 0: nColors - 1;

a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);

for count = 1 : nColors
    distance(:, :, count) = ((a - color_markers(count, 1)).^2 + (b - color_markers(count, 2)).^2).^0.5;
end

[~, label] = min(distance, [], 3);
label = color_labels(label);
clear distance;

%% 최근접이웃 분류에 대한 결과 표시하기
rgb_label = repmat(label, [1 1 3]);
segmented_images = zeros([size(fabric), nColors], 'uint8');

for count = 1 : nColors
    color = fabric;
    color(rgb_label ~= color_labels(count)) = 0;
    segmented_images(:, :, :, count) = color;
end

figure
montage({segmented_images(:, :, :, 2), segmented_images(:, :, :, 3), segmented_images(:, :, :, 4), segmented_images(:, :, :, 5), segmented_images(:, :, :, 6), segmented_images(:, :, :, 1)});
title("Montage of Red, Green, Purple, Magenta, and Yellow, Objects, and Background");

%% 레이블이 지정된 색의 'a*' 값과 'b*' 값 표시하기
plot_labels = cell([1 nColors]);
for count = 1 : nColors
    plot_labels{count} = lab2rgb([50 color_markers(count, 1) color_markers(count, 2)]);
end

figure
for count = 1:nColors
    plot(a(label==count-1), b(label==count-1), '.','MarkerEdgeColor', plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
    hold on;
end

title('Scatterplot of the segmented pixels in ''a*b*'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');
