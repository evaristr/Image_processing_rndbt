function backGrnd = getBackGrnd(filename, nTest, method)
    tic
    if nargin < 2, nTest = 20; end
    if nargin < 3, method = 'median'; end
    v = VideoReader(filename);
    nChannel = size(readFrame(v), 3);
    tTest = linspace(0, v.Duration-1/v.FrameRate , nTest);
    %allocate room for buffer
    buff = NaN([v.Height, v.Width, nChannel, nTest]);
    for fi = 1:nTest
        v.CurrentTime =tTest(fi);
        % read current frame and update model
        buff(:, :, :, mod(fi, nTest) + 1) = readFrame(v);
    end
    switch lower(method)
        case 'median'
            backGrnd = nanmedian(buff, 4);
        case 'mean'
            backGrnd = nanmean(buff, 4);
    end
    toc
end

