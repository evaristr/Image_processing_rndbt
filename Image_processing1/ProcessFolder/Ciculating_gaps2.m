clear all
close all
pickframe=[];
%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4',...
    'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
%%
% Setting frames to 5 because it is a short video. Set initial standard 
% deviation.
detector = vision.ForegroundDetector(...
       'NumTrainingFrames', 50, ... 
       'InitialVariance', 30*30); 
%%
% Perform blob analysis.
blob = vision.BlobAnalysis(...
       'CentroidOutputPort', false, 'AreaOutputPort', false, ...
       'BoundingBoxOutputPort', true, ...
       'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 250,...
       'OrientationOutputPort', true);

%% Develop a region of Interest
this_frame = read(video, 1);
 roiDetect = roipoly(this_frame);
 [row_ref, col_ref]= find(roiDetect);


%%
%.
%Initializing
videoPlayer = vision.VideoPlayer();
m = 1;
k = 0;
check = true;
while ~isDone(videoSource)
    frameRGB  = step(videoSource);
    fgMask1 = step(detector, frameRGB);
    fgMask2 = medfilt2(fgMask1);
    CC = bwconncomp(fgMask2, 8);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC);
    fgMask = ismember(L, find([S.Area] >=500));
   % [bbox, orientation] = step(blob, fgMask);
    
    sumValue = sum(fgMask(roiDetect));
       
     if (sumValue >150)% &&(orientation<(-pi()/2))
        pickframe=[pickframe k];
       %figure(k)
       %imshowpair(fgMask,frameRGB,'montage')
     end
     k = k +1;
end

frameDiff = pickframe(2:end)-pickframe(1:end-1);
Fn = find(frameDiff>15)+1;
frameEvent = pickframe(Fn);

for i = 1:length(frameEvent)
readFrame = read(video,frameEvent(i));
figure(i);
imshow(readFrame);
end
