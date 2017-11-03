function [yTrack] = removeSpikes(yTrack)
%REMOVESPIKES Remove single value upticks and downticks from yTrack
%   Detailed explanation goes here

% yTrackOriginal = yTrack;

%Removing singular upspikes and downspikes
for i = 2:length(yTrack)-5
    if yTrack(i,1) > yTrack(i-1,1) && mode(yTrack(i+1:i+3,1)) < yTrack(i,1)
        yTrack(i,1) = yTrack(i-1,1);
    elseif yTrack(i,1) < yTrack(i-1,1) && mean(yTrack(i+1:i+4,1)) > yTrack(i,1)
        yTrack(i,1) = yTrack(i-1,1);
    end
end

for i = 2:length(yTrack)-5
    if yTrack(i,2) > yTrack(i-1,2) && mode(yTrack(i+1:i+3,2)) < yTrack(i,2)
        yTrack(i,1) = yTrack(i-1,1);
    elseif yTrack(i,2) < yTrack(i-1,2) && mean(yTrack(i+1:i+4,2)) > yTrack(i,2)
        yTrack(i,2) = yTrack(i-1,2);
    end
end

% figure()
% hold on
% plot(yTrack(:,1))
% plot(yTrackOriginal(:,1))
% hold off

end

