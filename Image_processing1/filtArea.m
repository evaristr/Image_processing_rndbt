function filtered = filtArea(inputimage,greatThan)
    CC = bwconncomp(inputimage, 8);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC);
    filtered = ismember(L, find([S.Area] >=greatThan));
end