function [velocity, acceleration] = velAccPolyFit(yTrack, steps, sizePx, tFrame, numFrames, overlap)
%VELACCPOLYFIT Summary of this function goes here
%   Detailed explanation goes here
space = steps(1,2)-overlap:numFrames;

pDisp = polyfit(transpose(space),yTrack(steps(1,2)-overlap:end,1),6);

pVel = polyder(pDisp);
pVelVal = polyval(pVel,space) * sizePx / tFrame;

pAcc = polyder(pVel);
pAccVal = polyval(pAcc,space) * sizePx / (tFrame*tFrame);

velocity = transpose([space; pVelVal]);
acceleration = transpose([space; pAccVal]);
end

