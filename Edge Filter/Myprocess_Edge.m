I = double(imread('lena.tif'));
v1 = MySobelEdgeFilter(I);
v2 = MyPrewittEdgeFilter(I);
v3 = MyRobertsEdgeFilter(I);

imshow(v3, []);

%subplot(1, 3, 2);
%imshow(v2, []);

%subplot(1, 3, 3);
%imshow(v3, []);