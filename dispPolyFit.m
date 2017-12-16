function [displacement] = dispPolyFit(yTrack, steps, numFrames, overlap, order)
%DISPPOLYFIT Summary of this function goes here
%   Detailed explanation goes here

space = steps(1,2)-overlap:numFrames;

pDisp = polyfit(transpose(space),yTrack(steps(1,2)-overlap:end,1),order);
pDispVal = polyval(pDisp, space);

displacement = transpose([space; pDispVal]);
end

