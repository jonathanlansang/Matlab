function [ steps ] = findSteps( yTrack )
%FINDSTEPS finds frames that the bar moved a number of pixels relative to
%the previous position
%   Detailed explanation goes here
j = 1;

for i = 2:length(yTrack)
    if yTrack(i,1) ~= yTrack(i-1,1)
        steps(j,1) = yTrack(i,1); %step pixel #
        steps(j,2) = i; %step frame #
        j = j + 1;
    end
end

end

