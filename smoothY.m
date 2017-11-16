function [ yTrack ] = smoothY( yTrack )
%SMOOTHY removes any uptick - only allows the positive top bar velocity
%   Detailed explanation goes here

for i = 2:length(yTrack)
    if yTrack(i,1) > yTrack(i-1,1)
        yTrack(i,1) = yTrack(i-1,1);
    end
end


