clear all
close all

threshold = 0.45;
nTest = 15;
minArea = 100;
nFrames = 300;

% Create system objects to read file.
video = VideoReader('C:\Users\Evarist\Documents\Headway_1\trial2.mp4');
backgrnd = getBackGrnd('C:\Users\Evarist\Documents\Headway_1\trial2.mp4',nTest);
[x, y, z]=size(readFrame(video));
thresArray=repmat(threshold,x,y,z);
binary=zeros(x,y);
video = VideoReader('C:\Users\Evarist\Documents\Headway_1\trial2.mp4');
se =strel('disk',2);
i=1;
for j=1:nFrames
    thisFrame = read(video, j);
    binFrame = (abs(minus(double(thisFrame),backgrnd))./backgrnd)>thresArray;
    binFrame=nanmean(binFrame,3);
    binFrame=binFrame>binary;
    binFrame=imclose(binFrame,se);
    binFrame = bwareaopen(binFrame,minArea);
    binFrame = imfill(binFrame,'holes');
    if j== round((nFrames/nTest))*i
        imSave(:,:,i) = binFrame;
        i=i+1;
    end 
    imshowpair(binFrame,thisFrame,'montage')  
end

%for ii = 1:4
%  subplot(2,2,ii);
%  imshow(imSave(:,:,ii))
%end
   
