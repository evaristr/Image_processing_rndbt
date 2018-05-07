%%%
clear all
close all
pickframe=[];
%%
vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
%1. Reference line placing         
this_frame = read(vidReader, 4);
roiDetect = roipoly(this_frame);
[row_ref, col_ref]= find(roiDetect);


%%
% Create optical flow object.
opticFlow = opticalFlowLKDoG('NoiseThreshold',0.0039);
%%
% Estimate the optical flow of the objects and display the flow vectors.
% Initializing
m = 1;
k = 0;
vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
   while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    % Mask the image.
    maskedRgbImage = bsxfun(@times, frameRGB, cast(roiDetect,class(frameRGB)));
    frameGray = rgb2gray(maskedRgbImage);
    flow = estimateFlow(opticFlow,frameGray); 
    all_bw = bwlabel(flow.Magnitude);
    all_bw1 = imbinarize(all_bw,1);
    
    fgMask2 = medfilt2(all_bw1);
    CC = bwconncomp(fgMask2, 4);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC);
    fgMask = ismember(L, find([S.Area] >=50));
   % [bbox, orientation] = step(blob, fgMask);
    
    sumValue = sum(fgMask(roiDetect));
    
    
     if (sumValue >150)% &&(orientation<(-pi()/2))
        pickframe=[pickframe k];
        % figure(k)
        % imshowpair(fgMask,frameRGB,'montage')
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