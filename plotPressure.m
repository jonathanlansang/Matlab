function plotPressure(dpLeider, dpKuzma, steps)
%PLOTPRESSURE plot pressure at R=0 between both rods
%   Detailed explanation goes here

startPolyPlot = steps(1,2);

figure()
hold on

plot(dpLeider(:,1),dpLeider(:,2));
plot(dpKuzma(startPolyPlot:end,1),dpKuzma(startPolyPlot:end,2));

xlabel('Frame');
ylabel('Relative Pressure [Pa]');
hold off
end

