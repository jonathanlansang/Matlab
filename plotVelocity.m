function plotVelocity(velocity)
%PLOTVELOCITY plot velocity of the top rod
%   Detailed explanation goes here
figure();
plot(velocity(:,2),velocity(:,1));
xlabel('Frame');
ylabel('Velocity [m/s]');
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
end

