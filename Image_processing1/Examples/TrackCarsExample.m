%% Detect Moving Cars In Video
%
%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Dropbox\Trial_x264.mp4',...
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
% Insert a border.
shapeInserter = vision.ShapeInserter('BorderColor','White');

%%
% Play results. Draw bounding boxes around cars.
videoPlayer = vision.VideoPlayer();
k = 0;
while ~isDone(videoSource)
     frame  = step(videoSource);
     fgMask = step(detector, frame);
     if k == 20
         fgMask1 = fgMask;
     end
     k = k+1
end
%%
% Release objects.
release(videoPlayer);
release(videoSource);
