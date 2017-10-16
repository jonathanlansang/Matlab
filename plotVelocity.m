function plotVelocity(velocity)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
figure();
hold on
plot(velocity(:,2),velocity(:,1));
scatter(velocity(:,2),velocity(:,1));
xlabel('Frame');
ylabel('Velocity [m/s]');
hold off
%set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end
