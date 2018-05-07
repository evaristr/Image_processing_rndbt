function backGrnd = getBackGrnd2(video, initFrame, nTest, method)
    tic
    if nargin < 2, nTest = 20; end
    if nargin < 3, method = 'median'; end
    frameNumber = readFrame(video);
    nChannel = size(frameNumber, 3);
    tTest = linspace(0, video.Duration-1/video.FrameRate , nTest);
    %allocate room for buffer
    buff = NaN([video.Height, video.Width, nChannel, nTest]);
    for fi = initFrame:(nTest+initFrame-1)
        video.CurrentTime =tTest(fi);
        % read current frame and update model
        buff(:, :, :, fi) = readFrame(video);
    end
    switch lower(method)
        case 'median'
            backGrnd = nanmedian(buff, 3);
        case 'mean'
            backGrnd = nanmean(buff, 3);
    end
    toc
end

