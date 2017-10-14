function [velocity, acceleration] = velAcc(steps, sizePx, tFrame)
%VELACC Returns velocity and acceleration vectors for given position input
%using a central finite difference scheme
%   Function requires a position input in the form of a pixel and frame
%   number vector steps and two conversion constants (tframe and sizePx)
%   specifying the time length of a frame and the size of one pixel


velocity = zeros(length(steps)-1,2);
acceleration = zeros(length(velocity)-1,2);

for i = 2:length(steps) %starting at 2 because starting velocity is zero so no need to calculate that
    dPx = -(steps(i,1) - steps(i-1,1)); % neg. to correct y axis direction
    dFrames = steps(i,2) - steps(i-1,2);
    velocity(i,1) =  dPx * sizePx / (dFrames * tFrame);
    velocity(i,2) = (steps(i,2) + steps(i-1,2))/2;
end

for i = 2:length(acceleration) %starting at 2 because starting acceleration is zero
    dVel = velocity(i,1) - velocity(i-1,1); % neg. to correct y axis direction
    dFrames = velocity(i,2) - velocity(i-1,2);
    acceleration(i,1) =  dVel / (dFrames * tFrame);
    acceleration(i,2) = (velocity(i,2) + steps(i-1,2))/2;
end
