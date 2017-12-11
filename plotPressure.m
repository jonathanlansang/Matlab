function plotPressure(dpLeider, dpLeiderPolyFit, dpKuzma, steps, overlap)
%PLOTPRESSURE plot pressure at R=0 between both rods
%   Detailed explanation goes here
startPolyPlot = overlap/2;
endPolyPlot = length(dpKuzma)-overlap/2;

figure()
hold on

plot(dpLeider(:,1), dpLeider(:,2), 'LineWidth', 2);
plot(dpLeiderPolyFit(startPolyPlot:endPolyPlot,1),dpLeiderPolyFit(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
plot(dpKuzma(startPolyPlot:endPolyPlot,1),dpKuzma(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);

xlabel('Frame');
ylabel('Relative Pressure [Pa]');
hold off
end

