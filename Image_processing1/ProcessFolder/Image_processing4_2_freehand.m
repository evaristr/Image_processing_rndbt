%%
clear all
close all
pickframe=[];
%%
vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
%1. Reference line placing         
this_frame = read(vidReader, 4);
imshow(this_frame);
uiwait(msgbox('Draw a region with left button down.  Double click inside to finish it'));
h = imfreehand();
vertices = wait(h);
uiwait(msgbox('Draw another region with left button down.  Double click inside to finish it'));
h1 = imfreehand();
vertices1 = wait(h);
% Create a binary mask
roiDetect = createMask(h);
roiDetect1 = createMask(h1);
%roiDetect = roipoly(this_frame);
[row_ref, col_ref]= find(roiDetect);
[row_ref1, col_ref1]= find(roiDetect1);

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
    fgMask = ismember(L, find([S.Area] >=100));
   % [bbox, orientation] = step(blob, fgMask);
    
    sumValue = sum(fgMask(roiDetect));
    sumValue1 = sum(fgMask(roiDetect1));
    
    sumValue1 = [sumValue k]
    
    if (sumValue >50) &&(sumValue1 >50)
        pickframe=[pickframe k];
        % figure(k)
        % imshowpair(fgMask,frameRGB,'montage')
    end
    k = k +1;
end

frameDiff = pickframe(2:end)-pickframe(1:end-1);
Fn = find(frameDiff>30)+1;
frameEvent = pickframe(Fn);

%%
vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
for i = 1:length(frameEvent)
readFrame = read(vidReader,frameEvent(i));
figure(i);
imshowpair(fgMask,readFrame,'montage')
imshow(readFrame);
end