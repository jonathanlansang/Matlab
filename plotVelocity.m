function plotVelocity(velocity, velocityPoly, steps)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
startPolyPlot = steps(1,2);

figure();
hold on

plot(velocity(:,2),velocity(:,1));
scatter(velocity(:,2),velocity(:,1));
plot(velocityPoly(startPolyPlot:end,1),velocityPoly(startPolyPlot:end,2));

xlabel('Frame');
ylabel('Velocity [m/s]');
hold off
%set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end
