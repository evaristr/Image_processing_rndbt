clear all
close all

%%
%1. Reference line placing
refFrame = imread('C:\Users\Evariet\Documents\Headway_1\Snap3.jpg');
bkgnd_frame = imread('C:\Users\Evariet\Documents\Headway_1\Snap1.jpg');
Out = bitxor(bkgnd_frame,refFrame);
grayOut1 = rgb2gray(Out);
grayOut2 = imbinarize(grayOut1);
grayOut = medfilt2(grayOut2);
[row_ref, col_ref]= find(grayOut);

%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Documents\Headway_1\S1250002_x264.mp4',...
    'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
%%
% Setting frames to 5 because it is a short video. Set initial standard 
% deviation.
detector = vision.ForegroundDetector(...
       'NumTrainingFrames', 5, ... 
       'InitialVariance', 30*30); 
%%
% Perform blob analysis.
blob = vision.BlobAnalysis(...
       'CentroidOutputPort', false, 'AreaOutputPort', false, ...
       'BoundingBoxOutputPort', true, ...
       'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 250);

%%
% Estimate the optical flow of the objects and display the flow vectors.
%Initializing
videoPlayer = vision.VideoPlayer();
m = 1;
k = 0;
while ~isDone(videoSource)
     frameRGB  = step(videoSource);
     fgMask1 = step(detector, frameRGB);
     fgMask = medfilt2(fgMask1);
  sum = 0;   
  for i =1:size(row_ref)
         idx_1 = row_ref(i);
         idx_2 = col_ref(i);
         sum = sum + double(fgMask(idx_1,idx_2));
  end
     
     if sum ==15
        pickframe(m)=k;
        m = m+1;
        figure(k)
        imshowpair(fgMask,frameRGB,'montage')
     end
     k = k +1;
end

