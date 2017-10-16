function plotPressure(dp)
%PLOTPRESSURE plot pressure at R=0 between both rods
%   Detailed explanation goes here

figure()
hold on
plot(dp(:,2),dp(:,1));
xlabel('Frame');
ylabel('Relative Pressure [Pa]');
hold off
end

