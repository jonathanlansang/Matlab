function [yTrack] = lowPassFilter(yTrack,tFrame)
%LOWPASSFILTER Summary of this function goes here
%   Detailed explanation goes here

%Getting a vector of time vs time for fourier analysis
yTrackTimed(:,2) = yTrack(:,1);
for i = 1:length(yTrackTimed)
    yTrackTimed(i,1)= (i-1)*tFrame;
end


end

