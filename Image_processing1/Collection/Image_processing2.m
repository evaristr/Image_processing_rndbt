clear all
close all

%1. Reference line placing
refFrame = imread('C:\Users\Evariet\Dropbox\Project_Roundabouts\Image_processing\Image_processing1\vlcsnap-00001.png');
bkgnd_frame = imread('C:\Users\Evariet\Dropbox\Project_Roundabouts\Image_processing\Image_processing1\vlcsnap-00001_2.png');
Out = bitxor(bkgnd_frame,refFrame);
[row_ref, col_ref]= find(Out);

trafficVid = VideoReader('C:\Users\Evariet\Dropbox\Trial.mp4');
get(trafficVid)

%implay('C:\Users\Evariet\Dropbox\Trial.mp4');
nframes = trafficVid.NumberOfFrames;
size= zeros(trafficVid.Height, trafficVid.Width);
gray_ref = rgb2gray(Out);
[gray_ref2, num]=bwlabel(gray_ref);

%gray_ref = im2double(gray_ref1);
I3=zeros(trafficVid.Height, trafficVid.Width);
pickframe = zeros(nframes);
prev_avg = 0;

for k = 1 : nframes
    singleFrame = read(trafficVid, k);
 
    % Convert to grayscale to do morphological processing.
    gray1 = rgb2gray(singleFrame);
    sum = 0;
    count = 0;
    for i=1:trafficVid.Height
         for j=1:trafficVid.Width
             if gray_ref2(i,j)==1
                  sum=sum + double(gray1(i,j));
                  I3(i,j,2) = double(gray1(i,j));
                 if I3(i,j,2)~= I3(i,j,1)
                    count = count +1;
                 end
             end
        end
    end
    average = sum/count;
    
    avg_diff = abs(average - prev_avg);
    if avg_diff >=30&&k~=2
        pickframe(k)=k;
        imshow(gray1)
    end
    prev_avg = average;
end
