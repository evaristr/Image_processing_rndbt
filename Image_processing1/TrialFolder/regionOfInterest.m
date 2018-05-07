%% Develop a region of Interest
this_frame = read(video, 1);
this_frame = imresize(this_frame,2, 'Antialiasing',false);
 roiDetect = roipoly(this_frame);
 [row_ref, col_ref]= find(roiDetect);
 sizeROI = size(roiDetect,1)*size(roiDetect,2);
 
 
     if ((sumValue/sizeROI)*100>70)
        pickframe=[pickframe k];
    end