%% Compute Optical Flow Using Lucas-Kanade derivative of Gaussian
% Read in a video file. 

% Copyright 2015 The MathWorks, Inc.

vidReader = VideoReader('C:\Users\Evariet\Documents\Headway_1\S1250002_x264.mp4');
%%
% Create optical flow object.
opticFlow = opticalFlowLKDoG('NumFrames',3);
%%
% Estimate the optical flow of the objects and display the flow vectors.
   while hasFrame(vidReader)
     frameRGB = readFrame(vidReader);
     frameGray = rgb2gray(frameRGB);
     
     flow = estimateFlow(opticFlow,frameGray); 
     
     imshow(frameRGB); 
     hold on;
     plot(flow,'DecimationFactor',[5 5],'ScaleFactor',25);
     hold off; 
   end  