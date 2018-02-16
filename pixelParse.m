function [ topRodY,bottomRodY ] = pixelParse( image )
%PIXELPARSE Summary of this function goes here
%   Detailed explanation goes here

range = size(image);
yRange = range(1);
xRange = range(2);
yDev = 1; % allowed pixed deviation

column = image(:,1);
topRodY(1) = min(find(column == 0));
column2 = flipud(column);
bottomRodY(1) = min(find(column2 == 0));

for i = 2:xRange
    column = image(:,i);
    topPosCheck = min(find(column == 0));
    if ~isempty(topPosCheck) && (abs(topRodY(i-1) - topPosCheck) <= yDev)
        topRodY(i) = topPosCheck;
    else
        topRodY(i) = topRodY(i-1);
    end
    column2 = flipud(column);
    bottomPosCheck = min(find(column2 == 0));
    if ~isempty(bottomPosCheck) && (abs(bottomRodY(i-1) - bottomPosCheck) <= yDev)
        bottomRodY(i) = bottomPosCheck;
    else
        bottomRodY(i) = bottomRodY(i-1);
    end
end

end

