function [ image_processed ] = bubbleProcess( image,ybound,dev )
%BUBBLEPROCESS Preprocessing bubble image frames
%   Detailed explan

%% Area to Check for Bubbles
ymin = min(ybound);
ymax = max(ybound);
rect = [15-dev,ymin-dev,373-15+dev,ymax-ymin+dev];
image_cropped = rgb2gray(imcrop(image,rect));

%% Filtering Cropped Images



end

