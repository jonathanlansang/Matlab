function [dp] = relPressureKuzma(displacement, velocity, acceleration, botRodPos, rodDiameter, sizePx, density, viscosity)
%RELPRESSUREKUZMA returns relative pressure according to Kuzma for given velocity, rodDistance and
%rodDiameter. Adjust values for viscosity, non-newtonian fluids etc,

%% Constants
%n = 1; % unitless constant, 1 for Newtonian
mu = viscosity; % viscosity [kg/ms] for Newtonian
rho = density;
R = rodDiameter/2; % radius of rod/plate [m]
r = 0; % 0 to R
dp = zeros(length(displacement),2);

t = displacement(:,1);
rodPos = displacement(:,2);
hdot = velocity(:,2);
hdotdot = acceleration(:,2);

% Calculating pressure difference from polynomial interpolation
for i = 1:length(rodPos)
    dp(i,1) = t(i);
    
    h = (botRodPos - rodPos(i))* sizePx;
    dp(i,2) = ((r^2 - R^2) / 2) * ((6*mu*hdot(i)) / (h^3) ...
        + (3*rho*hdotdot(i)) / (5*h) - (15*rho*hdot(i)^2) / (14*h^2));
end

end