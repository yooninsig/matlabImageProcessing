%% Harris Corner Detection
I=imread('ireland02-small.tif');

if ~ismatrix(I)
    I=rgb2gray(I);
end

figure, imshow(I), title('Original image')

k=0.04;
thresh=5;
I=im2double(I);

%% Find Horizontal Derivative Ix, Square it, Smooth it
f=[-1 0 1;-1 0 1;-1 0 1;];
Ix=imfilter(I,f,'replicate');
Ix2=Ix.^2;
G=fspecial('gaussian',7,2);
%figure,imshow(mat2gray(Ix2)), title('A');
Ix2=imfilter(Ix2, G, 'replicate');

%% Find Vertical Derivative Iy, Square it, Smooth it
f=[-1 -1 -1;0 0 0;1 1 1;];
Iy=imfilter(I,f,'replicate');
Iy2=Iy.^2;
%figure,imshow(mat2gray(Iy2)), title('B');
Iy2=imfilter(Iy2, G, 'replicate');

%% Find Ix*Iy, Smooth it
IxIy=Ix.*Iy;
%figure, imshow(mat2gray(IxIy)),title('C');
IxIy=imfilter(IxIy,G,'replicate');

%% Find R=(Ix2  . * Iy2 - (IxIy).^2) - k(Ix2 + Iy2).^2
R=(Ix2.*Iy2 - (IxIy).^2)-k*((Ix2+Iy2).^2);
%figure, imshow(mat2gray(R)), title('R');

%% In R, find the local maxima and threshold the corners by given thresh value
Out=im2uint8(R);
[rows,cols]=size(I);


Corners=[];
count=1;

winSize=3;

for r = 2:rows-1
    for c = 2:cols-1
        
        %patch = Out(r:r+winSize-1,c:c+winSize-1);
        patch=Out(r-1:r+1,c-1:c+1);
       
        %%% find local maxima
        [maxv,ind]=max(patch(:));
        patch(:)=0;
        %% threshold the maxima
        if maxv >=thresh && ind==5
            %patch(ind)=maxv;
            if count ==1
                Corners=[uint16(c) uint16(r) uint16(maxv)];
            else
                Corners=[Corners; uint16(c) uint16(r) uint16(maxv)];
            end
            count=count+1;
        end
        %Out(r:r+winSize-1,c:c+winSize-1)=patch;
    end
end

[sortQ,idx]=sortrows(Corners,3,'descend');

dmin=10;
goodCorners=[];
count=1;
for i=1:length(idx)
    c0=double(sortQ(i,1:2));
    if c0(1)~=0&&c0(2)~=0
        if count==1
            goodCorners=c0;
        else
            goodCorners=[goodCorners;c0];
        end
        count=count+1;
        
        for j=i+1:length(idx)
            cj=double(sortQ(j,1:2));
            distance=sqrt((c0(1)-cj(1))^2 + (c0(2)-cj(2))^2);
            if distance <=dmin
                sortQ(j,:)=NaN;
            end
        end
    end
end

%Corners=Out;
figure; imshow(I)
hold on
for i=1:length(Corners)
    plot(Corners(i,1),Corners(i,2),'r+');
end
hold off

figure; imshow(I)
hold on
for i=1:length(goodCorners)
    plot(goodCorners(i,1), goodCorners(i,2),'b+');
end
hold off
        