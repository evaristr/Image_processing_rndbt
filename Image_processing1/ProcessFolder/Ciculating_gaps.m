clear all
close all

%%
% Create system objects to read file.
videoSource = vision.VideoFileReader('C:\Users\Evariet\Documents\Headway_1\S1250002_x264.mp4',...
    'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
video = VideoReader('C:\Users\Evariet\Documents\Headway_1\S1250002_x264.mp4');
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

for k = 1 : 40          
        %fill in the no of frames the video contains or anything less than that, The                    
%no of frames in a video can be identified by reading info about the video. 
        %i.e. the frame rate in fps, multiply it with video length in sec.
this_frame = read(video, k);
end
 roiDetect = roipoly(this_frame);
 [row_ref, col_ref]= find(roiDetect);


%%
% Estimate the optical flow of the objects and display the flow vectors.
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
    bbox = step(blob, fgMask);
    
    if size(bbox,1)~=0
        
    while check
       for i =1:size(row_ref)
           for j = 1:size(bbox,1)
            if((bbox(j,1)+bbox(j,3)) == col_ref(i)&&(bbox(j,2)+bbox(j,4)) == row_ref(i))
                pickframe(m)=k;
                m = m+1;
                figure(k)
                imshowpair(fgMask,frameRGB,'montage')
                check = false;                                 
            end
           end 
       end
    end
    for j = 1:size(bbox,1)
        if(bbox(j,1) >= min(col_ref) && bbox(j,2) >= max(row_ref))
            check = true;                                 
        end
    end
    end
     k = k +1;
end

