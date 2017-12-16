function plotCombined(numFrames, yTrack, steps, velocityPoly,...
    accelerationPoly, reynoldsNumber, relPressureLeiderPolyFit,...
    relPressureKuzma, overlap, polyFitOrder)
%PLOTCOMBINED Summary of this function goes here
%   Detailed explanation goes here

%General
startPolyPlot = overlap/2;
endPolyPlot = length(velocityPoly)-overlap/2;


%Displacement
spacelarge = 1:numFrames;
space = steps(1,2)-overlap:numFrames;
poly = polyfit(transpose(space),yTrack(steps(1,2)-overlap:end,1),polyFitOrder);
dispVal = polyval(poly,space);

%Pressure


figure()
subplot(5,1,1);
hold on
plot(spacelarge,yTrack(:,1), 'LineWidth', 2) %position of top rod
plot(spacelarge,yTrack(:,2), 'LineWidth', 2) %position of bottom rod
scatter(steps(:,2),steps(:,1), 'LineWidth', 2)
plot(space,dispVal, 'LineWidth', 2)
ylabel('Number of Pixels')
legend('Position of Top Rod','Position of Bottom Rod','Step Positions',...
    [num2str(polyFitOrder) '-Degree Polynomial Fit (First Step Start)'],...
    'Location', 'southwest')
xlim([0 1400]);
hold off

subplot(5,1,2);
hold on
plot(velocityPoly(startPolyPlot:endPolyPlot,1),...
    velocityPoly(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
hLine = refline(0,0); hLine.Color = 'k';
set(get(get(hLine,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off')
xlim([0 1400]);

ylabel('Velocity [m/s]');
legend('Velocity of Top Rod', 'Location', 'northwest');
hold off

subplot(5,1,3);
hold on
plot(accelerationPoly(startPolyPlot:endPolyPlot,1),...
    accelerationPoly(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
hLine = refline(0,0); hLine.Color = 'k';
set(get(get(hLine,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off')
xlim([0 1400]);

ylabel('Acceleration [m/s^2]');
legend('Acceleration of Top Rod', 'Location', 'northwest');
hold off

subplot(5,1,4);
hold on
plot(relPressureLeiderPolyFit(startPolyPlot:endPolyPlot,1),...
    relPressureLeiderPolyFit(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
plot(relPressureKuzma(startPolyPlot:endPolyPlot,1),...
    relPressureKuzma(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
hLine = refline(0,0); hLine.Color = 'k';
set(get(get(hLine,'Annotation'),'LegendInformation'),...
    'IconDisplayStyle','off')
xlim([0 1400]); ylim([-8e4 6e4]);

ylabel('Relative Pressure [Pa]');
legend('Relative Pressure Change Leider',...
    'Relative Pressure Change Kuzma',...
    'Location', 'northwest')
hold off

subplot(5,1,5);
hold on
plot(reynoldsNumber(startPolyPlot:endPolyPlot,1),...
    reynoldsNumber(startPolyPlot:endPolyPlot,2), 'LineWidth', 2);
hLine = refline(0,100); hLine.Color = 'k';
set(gca, 'YScale', 'log')
xlim([0 1400]); ylim([0 1e4]);


ylabel('Reynolds Number [-]');
xlabel('Frame');
legend('Instantaneous Reynolds Number','Re=100', 'Location', 'northwest');

hold off

end

