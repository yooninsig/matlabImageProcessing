%% 이미지 합치기
%imfuse( ) 함수를 사용하여 영상 합성
A = imread('cBeach.tif');
B = imread('cShip.tif');

C = imfuse(A, B);
imshow(C);