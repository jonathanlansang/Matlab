function plotAcceleration(acceleration, accelerationPoly, steps)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
startPolyPlot = steps(1,2);


figure();
hold on
plot(acceleration(:,2),acceleration(:,1));
scatter(acceleration(:,2),acceleration(:,1));
plot(accelerationPoly(startPolyPlot:end,1),accelerationPoly(startPolyPlot:end,2));


xlabel('Frame');
ylabel('Velocity [m/s]');
hold off
%set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end
