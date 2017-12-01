function [topRodY2,bottomRodY2] = findEdges2(image,threshold)
%FINDEDGES2 uses threshold value to generate binary rod image 
%   Detailed explanation goes here


%% Filtering Cropped Images
image_processed = (image<threshold);
image_filled = imfill(image_processed,'holes');

%% Find Precise Top/Bottom Edges
range = size(image_filled);
yRange = range(1);
xRange = range(2);
yDev = 1; % allowed pixed deviation

column = image_filled(:,1);
topRodY(1) = min(find(column == 0));
column2 = flipud(column);
bottomRodY(1) = min(find(column2 == 0));

for i = 2:xRange
    column = image_filled(:,i);
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

topRodY2 = median(topRodY);
bottomRodY2 = median(bottomRodY);