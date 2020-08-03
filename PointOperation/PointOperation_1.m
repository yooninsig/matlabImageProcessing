%% Point Operation
I = imread('lena.tif');
J = imread('lena.tif');

%imadd() 함수를 이용한 이미지 더하기 연산
%imshowpair() 함수를 이용하여 이미지 비교(montage) 인자
J = imadd(I, 100);
imshowpair(I, J, 'montage');

%imsubtract() 함수를 이용한 이미지 빼기 연산
J = imsubtract(I, 100);
imshowpair(I, J, 'montage');

%immultiply() 함수를 이용한 이미지 곱하기 연산
J = immultiply(I, 0.5);
imshowpair(I, J, 'montage');

%imdivide() 함수를 이용한 이미지 나누기 연산
J = imdivide(I, 4);
imshowpair(I, J, 'montage');