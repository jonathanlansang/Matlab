function [displacement] = dispPolyFit(yTrack, steps, numFrames, overlap)
%DISPPOLYFIT Summary of this function goes here
%   Detailed explanation goes here

space = steps(1,2)-overlap:numFrames;

pDisp = polyfit(transpose(space),yTrack(steps(1,2)-overlap:end,1),6);
pDispVal = polyval(pDisp, space);

displacement = transpose([space; pDispVal]);
end

