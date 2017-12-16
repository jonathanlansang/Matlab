function reynoldsNumber = reynoldsNumber(displacement, velocity, density, viscosity, sizePx, botRodPos)
%REYNOLDSNUMBER Summary of this function goes here
%   Detailed explanation goes here
reynoldsNumber = zeros(size(velocity,1),2);

for i = 1:length(velocity)
    h = (botRodPos - displacement(i,2))* sizePx;
    reynoldsNumber(i,1) = displacement(i,1);
    reynoldsNumber(i,2) = density*velocity(i,2)*h/viscosity;
end

end

