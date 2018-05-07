clear all
close all
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4',...
    'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
%video = VideoReader('C:\Users\Evarist\Documents\Headway_1\trial2.mp4');
%%
% Setting frames to 5 because it is a short video. Set initial standard 
% deviation.
detector = vision.ForegroundDetector(...
       'NumTrainingFrames', 50, ... 
       'InitialVariance', 30*30); 
   
m = 1;
k = 0;
videoPlayer = vision.VideoPlayer(); 
 while ~isDone(videoSource)
    frameRGB  = step(videoSource);
    fgMask1 = step(detector, frameRGB);
    fgMask2 = medfilt2(fgMask1);
    CC = bwconncomp(fgMask2, 8);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC);
    fgMask = ismember(L, find([S.Area] >=50));
    [bbox, orientation] = step(blob, fgMask);
       
     if (k==100*m)
       figure(k)
       imshowpair(fgMask,frameRGB,'montage')
       m = m+1;
     end
     k = k +1;
end