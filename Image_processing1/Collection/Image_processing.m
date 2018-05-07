clear all
close all

trafficVid = VideoReader('C:\Users\Evariet\Dropbox\Trial.mp4')
frame1 = imread('C:\Users\Evariet\Dropbox\Project_Roundabouts\Image_processing\Image_processing1\vlcsnap-00001.png');
get(trafficVid)

%implay('C:\Users\Evariet\Dropbox\Trial.mp4');
nframes = trafficVid.NumberOfFrames;
I = read(trafficVid, 1);
size= zeros(trafficVid.Height, trafficVid.Width);
I2 = rgb2gray(frame1);
I3=zeros(trafficVid.Height, trafficVid.Width);


for k = 1 : 5
    singleFrame = read(trafficVid, k);
    %singleFrame1 = singleFrame(:,:,1);
    %singleFrame2 = singleFrame(:,:,2);
    %singleFrame3 = singleFrame(:,:,3);
    
    % Convert to grayscale to do morphological processing.
    I = rgb2gray(singleFrame);
    
end
frame11= frame1(:,:,1);
frame12= frame1(:,:,2);
frame13= frame1(:,:,3);
%image(singleFrame1);
sum = 0;
count = 0;
for i=1:trafficVid.Height
     for j=1:trafficVid.Width
         if I2(i,j)==255
             I3(i,j)=1;
             sum = sum + I(i,j);
             count = count +1;
         end
        
    end
end
average = sum/count;
Image= I3(:,:,1);
imshow(I3)

%image(singleFrame2)
%image(singleFrame3)