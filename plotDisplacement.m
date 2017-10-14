function plotDisplacement( numFrames,yTrack,steps )
%PLOTDISPLACEMENT plot position of top and bottom rod as well as steps of
%the top rod
%   Detailed explanation goes here
figure();
space = linspace(1,numFrames,length(yTrack));
hold on
plot(space,yTrack(:,1))
plot(space,yTrack(:,2)) %position of bottom rod
scatter(steps(:,2),steps(:,1))
xlabel('Frame')
ylabel('Number of Pixels')
legend('Step Positions','Position of top rod')
hold off


end

