%clear all
%close all
clearvars -except totArea row_ref col_ref roiDetect
pickframe=[];

threshold = 0.45;
threshArea = 0.5;
nTest = 20;
minArea = 100;
nFrames = 3000;

% Create system objects to read file.C:\Users\Evarist\OneDrive - Florida State University\Headway_1
video = VideoReader('C:\Users\Evariet\OneDrive - Florida State University\Headway_1\clip111.avi');
numFrames = ceil(video.FrameRate*video.Duration);
backgrnd = getBackGrnd('C:\Users\Evariet\OneDrive - Florida State University\Headway_1\clip111.avi',nTest);
[x, y, z]=size(read(video,1));
thresArray=repmat(threshold,x,y,z);
binary=zeros(x,y);
video = VideoReader('C:\Users\Evariet\OneDrive - Florida State University\Headway_1\clip111.avi');
se =strel('disk',2);
i=1;

%% Develop a region of Interest
if exist('roiDetect','var')==0
    this_frame = read(video, 1);
    roiDetect = roipoly(this_frame);
    totArea = sum(roiDetect(:)==1);
    threshArea = threshArea*totArea;
end
 %[row_ref, col_ref]= find(roiDetect);

%% Run detection
%nFrames=numFrames;
j=1;
video1 = VideoReader('C:\Users\Evariet\OneDrive - Florida State University\Headway_1\clip111.avi');
 while hasFrame(video1)
    thisFrame = readFrame(video1);
    binFrame = (abs(minus(double(thisFrame),backgrnd))./backgrnd)>thresArray;
    binFrame = nanmean(binFrame,3);
    binFrame = binFrame>binary;
    binFrame1 = binFrame;
    binFrame = imclose(binFrame,se);
    binFrame = bwareaopen(binFrame,minArea);
    binFrame = imfill(binFrame,'holes');
    sumValue(j) = sum(binFrame(roiDetect));
       
     if (sumValue(j)>threshArea)% &&(orientation<(-pi()/2))
       pickframe=[pickframe j];
       %figure(k)
       %imshowpair(binFrame1,binFrame,'montage')
     end
     j=j+1;
     if j==nFrames
         break
     end
end
 
%%

frameDiff = pickframe(2:end)-pickframe(1:end-1);
Fn = find(frameDiff>5)+1;
frameEvent = [pickframe(1),pickframe(Fn)];
%frameEvent = pickframe(Fn);

%video = VideoReader('C:\Users\Evariet\OneDrive - Florida State University\Headway_1\clip222.avi');
%for i = 1:length(frameEvent)
%readFrame = read(video,frameEvent(i));
%figure(i);
%imshow(readFrame);
%end


%for i = 1:nFrames
%readFrame = read(video,i);
%figure(i);
%imshow(readFrame);
%end

subplot(2,1,1)
plot(sumValue)

subplot(2,1,2)
plot(frameDiff)

%Headway Calculation
headValue=(frameEvent(2:end)-frameEvent(1:end-1))./30;