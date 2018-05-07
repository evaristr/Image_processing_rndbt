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
opticFlow = opticalFlowLKDoG('NoiseThreshold',0.0003);

%%
% Estimate the optical flow of the objects and display the flow vectors.
% Initializing
m = 10;
k = 1;
vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    % Mask the image.
    maskedRgbImage = bsxfun(@times, frameRGB, cast(roiDetect,class(frameRGB)));
    frameGray = rgb2gray(maskedRgbImage);
    flow = estimateFlow(opticFlow,frameGray); 
    all_bw = bwlabel(flow.Magnitude);
    all_bw1 = imbinarize(all_bw,1);
    sumValue = sum(all_bw1(roiDetect));
     if (k >5*m)
         imshowpair(all_bw1,frameRGB,'montage')
     end
     k = k +1;
end
