function [yTrack] = removeSpikes(yTrack,tFrame)
%REMOVESPIKES Remove single value upticks and downticks from yTrack
%   Detailed explanation goes here

% %Getting a vector of time vs time for fourier analysis
% yTrackTimed(:,2) = yTrack(:,1);
% for i = 1:length(yTrackTimed)
%     yTrackTimed(i,1)= (i-1)*tFrame;
% end

% yTrackOriginal = yTrack;

%Removing singular upspikes and downspikes
for i = 2:length(yTrack)-4
    if yTrack(i,1) > yTrack(i-1,1) && mode(yTrack(i+1:i+3,1)) < yTrack(i,1)
        yTrack(i,1) = yTrack(i-1,1);
    elseif yTrack(i,1) < yTrack(i-1,1) && mode(yTrack(i+1:1+3,1)) > yTrack(i,1)
        yTrack(i,1) = yTrack(i-1,1);
    end
end

% figure()
% hold on
% plot(yTrack(:,1))
% plot(yTrackOriginal(:,1))
% hold off

end

