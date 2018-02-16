function plotDisplacement(numFrames, yTrack, steps, overlap, order)
%PLOTDISPLACEMENT plot position of top and bottom rod as well as steps of
%the top rod
%   Detailed explanation goes here
% figure();
space = 1:numFrames;
space2 = steps(1,2)-overlap:numFrames;
p1 = polyfit(transpose(space),yTrack(:,1),order);
y1 = polyval(p1,space);
p2 = polyfit(transpose(space2),yTrack(steps(1,2)-overlap:end,1),order);
y2 = polyval(p2,space2);
% bSplineKnots = spmak(steps(:,2),steps(:,1));
% spaceB = linspace(space2(1),length(space2)+space2(1),length(bSplineKnots.knots));

hold on
plot(space,yTrack(:,1), 'LineWidth', 2) %position of top rod
plot(space,yTrack(:,2), 'LineWidth', 2) %position of bottom rod
scatter(steps(:,2),steps(:,1), 'LineWidth', 2)
plot(space,y1, 'LineWidth', 2)
plot(space2,y2, 'LineWidth', 2)
% plot(spaceB,-bSplineKnots.knots+yTrack(1,1)+bSplineKnots.knots(1))
xlabel('Frame')
ylabel('Number of Pixels')
legend('Position of Top Rod','Position of Bottom Rod','Step Positions')
hold off

legend('Position of Top Rod','Position of Bottom Rod','Step Positions',...
    [num2str(order) '-Degree Polynomial Fit (Start Position)'],...
    [num2str(order) '-Degree Polynomial Fit (First Step Start)'])
hold off



end

