function [topRodY,bottomRodY] = findEdges2(image,threshold)
%FINDEDGES2 uses threshold value to generate binary rod image 
%   Detailed explanation goes here


%% Filtering Cropped Images
image_processed = (image<threshold);
image_filled = imfill(image_processed,'holes');

%% Find Precise Top/Bottom Edges
[topRodY,bottomRodY] = pixelParse(image_filled);

