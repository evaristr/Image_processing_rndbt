%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4',...
    'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
%video = VideoReader('C:\Users\Evarist\Documents\Headway_1\trial2.mp4');

%% Blob analysis
% Load blob analysis
blob = vision.BlobAnalysis(...
       'CentroidOutputPort', false, 'AreaOutputPort', false, ...
       'BoundingBoxOutputPort', true, ...
       'MinimumBlobAreaSource', 'Property', 'MinimumBlobArea', 250,...
       'OrientationOutputPort', true);

% Use blob analysis in detection of issues like area, boundigbox etc
bbox = step(blobAnalysis, filteredForeground);

