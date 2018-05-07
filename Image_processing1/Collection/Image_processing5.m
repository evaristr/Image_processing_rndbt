%% Detect Moving Cars In Video


%%
%1. Reference line placing
refFrame = imread('C:\Users\Evariet\Dropbox\Project_Roundabouts\Image_processing\Image_processing1\vlcsnap-00001.png');
bkgnd_frame = imread('C:\Users\Evariet\Dropbox\Project_Roundabouts\Image_processing\Image_processing1\vlcsnap-00001_2.png');
Out = bitxor(bkgnd_frame,refFrame);
grayOut = rgb2gray(Out);
[row_ref, col_ref]= find(grayOut);

%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Dropbox\Trial.mp4',...
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
    sum = 1;
     k = 1;
     for i =1:size(row_ref)
         idx_1 = row_ref(i);
         idx_2 = col_ref(i);
         sum = sum + double(fgMask(idx_1,idx_2));
     end
     
     if sum ==30
        %pickframe(m)=k;
        m = m+1;
        imshow(frameRGB)
     end
     k = k +1;
end
%%
% Release objects.
release(videoPlayer);
release(videoSource);
