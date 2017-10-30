function [ frames_cropped ] = cropInfoBar(frames,numFrames,acqRes)
%CROPINFOBAR crops out the information bar 
%   frames: frames with information bar
%   frames_cropped: frames without information bar
%   xBound: x parameters to crop
%   yBar: top Y-coordinate of the 

xmax = acqRes(1);
xmin = 0;
height = acqRes(2);
width = xmax - xmin;
rect = [xmin,0,width,height];
frames_cropped = {zeros(1,numFrames)};

for i = 1:numFrames
    frames_cropped{i} = imcrop(frames{i}, rect);
end

end

