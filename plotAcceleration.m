function plotAcceleration(acceleration, accelerationPoly, steps, overlap)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
startPolyPlot = overlap/2;
endPolyPlot = length(accelerationPoly)-overlap/2;

figure();
hold on
plot(acceleration(:,2),acceleration(:,1));
scatter(acceleration(:,2),acceleration(:,1));
plot(accelerationPoly(startPolyPlot:endPolyPlot,1),accelerationPoly(startPolyPlot:endPolyPlot,2));


xlabel('Frame');
ylabel('Acceleration [m/s^2]');
hold off
%set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end
