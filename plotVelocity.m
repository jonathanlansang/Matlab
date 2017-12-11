function plotVelocity(velocity, velocityPoly, steps, overlap)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
startPolyPlot = overlap/2;
endPolyPlot = length(velocityPoly)-overlap/2;

figure();
hold on

plot(velocity(:,2),velocity(:,1));
scatter(velocity(:,2),velocity(:,1));
plot(velocityPoly(startPolyPlot:endPolyPlot,1),velocityPoly(startPolyPlot:endPolyPlot,2));

xlabel('Frame');
ylabel('Velocity [m/s]');
hold off
%set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end
