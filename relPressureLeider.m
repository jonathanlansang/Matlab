function [dp, dpPolyFit] = relPressureLeider(velocity, steps, velocityFit, displacementFit, botRodPos, rodDiameter, sizePx, viscosity)
%RELPRESSURE returns relative pressure for given velocity, rodDistance and
%rodDiameter
%   Adjust values for viscosity, non-newtonian fluids etc,

%% Constants
n = 1; % unitless constant, 1 for Newtonian
m = viscosity; % viscosity [kg/ms] for Newtonian
R = rodDiameter/2; % radius of rod/plate [m]
r = 0; % 0 to R
dp = zeros(length(velocity),2);
dpPolyFit = zeros(length(displacementFit),2);

% Calculating pressure difference for every discretely calculated velocity,
% using gap height at time of velocity measurement (average of before and
% after pixel jump gap heights). Calculated for the same frame as the
% velocity
for i = 2:length(velocity)
    dp(i,1) = velocity(i,2);
    
    rodDistance = (botRodPos - (steps(i,1)+steps(i-1))/2)* sizePx;
    rodVelocity = velocity(i,1);
    dp(i,2) = -(rodVelocity)^n/(rodDistance^(2*n+1))*((2*n+1)/(2*n))^n*(m*R^(n+1))/(n+1)*(1-(r/R)^(n+1));
end

t = displacementFit(:,1);
rodPos = displacementFit(:,2);
hdot = velocityFit(:,2);

for i = 1:length(rodPos)
    dpPolyFit(i,1) = t(i);
    
    h = (botRodPos - rodPos(i))* sizePx;
    dpPolyFit(i,2) = -(hdot(i))^n/(h^(2*n+1))*((2*n+1)/(2*n))^n*(m*R^(n+1))/(n+1)*(1-(r/R)^(n+1));
end


end
