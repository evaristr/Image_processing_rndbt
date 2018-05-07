clear all
close all


threshold = 50;
% Create system objects to read file.
video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
[x, y, z]=size(readFrame(video));
binary=repmat(threshold,x,y,z);

for i=1:20:60
    video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
    backgrnd = getBackGrnd2(video,i,20, 'median');
    video = VideoReader('C:\Users\Evariet\Documents\Headway_1\trial2.mp4');
    for j=i:(20+i-1)
        thisFrame = read(video, j);
        binFrame=(minus(double(thisFrame),backgrnd)>binary);
    end
    
end
        
    
