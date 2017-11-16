function [frames_box] = boundaryBoxHelper(yBound,xBound,frames,boxPlotStart,boxPlotEnd,fps,playMovie)
%BOUNDARYBOXHELPER Displays image with box overlay
%   Box shows the gap in between the rods 

numFrames = length(frames);
xmin = min(xBound);
xmax = max(xBound);
frames_box = {zeros(1,numFrames)};
    
for i = 1:numFrames
    ymin = min(yBound(i,1));
    ymax = max(yBound(i,2));

    width = xmax - xmin;
    height = ymax - ymin;

    rect = [xmin,ymin,width,height];
    frames_box{i} = insertShape(frames{i},'Rectangle',rect);
    F(i) = im2frame(imresize(frames_box{i},2.8));
end

if playMovie
    movie(F,[1,boxPlotStart:boxPlotEnd],fps);
end
