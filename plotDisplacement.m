function plotDisplacement( numFrames,yTrack,steps )
%PLOTDISPLACEMENT plot position of top and bottom rod as well as steps of
%the top rod
%   Detailed explanation goes here
figure();
space = linspace(1,numFrames,length(yTrack));
hold on
plot(space,yTrack(:,1)) %position of top rod
plot(space,yTrack(:,2)) %position of bottom rod
scatter(steps(:,2),steps(:,1))
xlabel('Frame')
ylabel('Number of Pixels')
legend('Position of Top Rod','Position of Bottom Rod','Step Positions')
hold off


end

