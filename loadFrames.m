function [frames,numFrames] = loadFrames(video)

i = 1;
v = VideoReader(video);

while hasFrame(v)
    frames{i} = readFrame(v);
    i = i + 1;
end

numFrames = length(frames);