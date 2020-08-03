%% 두개의 이미지를 이용하여 알파블렌딩 하기
%% 알파 값은 0.5
A = imread('cBeach.tif');
B = imread('cShip.tif');

%영상의 size 확인
[ha, wa] = size(A);
[hb, wb] = size(B);

if ha == hb
    height = ha;
end
if wa == wb
    width = wa;
end

alpha = 0.5;
J = zeros(height, width);

for y = 1 : height
    for x = 1 : width
        Pa = double(A(y, x));
        Pb = double(B(y, x));
        
        n = Pa * (1 - alpha);
        m = Pb * alpha;
        b = n + m;
        
        J(y, x) = b;
    end
end

subplot(1, 3, 1);
imshow(A);
title('cBeach.tif');

subplot(1, 3, 2);
imshow(B);
title('cShip.tif');

subplot(1, 3, 3);
imshow(J, []);
title('Alpha Blending A with B');
