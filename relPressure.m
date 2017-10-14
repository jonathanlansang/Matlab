function [dp] = relPressure(velocity, steps, botRodPos, rodDiameter, sizePx)
%RELPRESSURE returns relative pressure for given velocity, rodDistance and
%rodDiameter
%   Adjust values for viscosity, non-newtonian fluids etc,

%% Constants
n = 1; % unitless constant, 1 for Newtonian
m = 10^-3; % viscosity [kg/ms] for Newtonian
R = rodDiameter/2; % radius of rod/plate [m]
r = 0; % 0 to R
dp=zeros(length(velocity),2);

% Calculating pressure difference for every discretely calculated velocity,
% using gap height at time of velocity measurement (average of before and
% after pixel jump gap heights). Calculated for the same frame as the
% velocity
for i = 2:length(velocity)
    rodDistance = (botRodPos - (steps(i,1)+steps(i-1))/2)* sizePx;
    rodVelocity = velocity(i,1);
    dp(i,1) = -(rodVelocity)^n/(rodDistance^(2*n+1))*((2*n+1)/(2*n))^n*(m*R^(n+1))/(n+1)*(1-(r/R)^(n+1));
    dp(i,2) = velocity(i,2);
end