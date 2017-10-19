function [ image_processed ] = bubbleProcess( image,ybound,dev )
%BUBBLEPROCESS Preprocessing bubble image frames
%   image = uint8 rgb image/frame to process
%   ybound = yTracks; % position of top and bottom rod
%   dev = pixel buffer between tracking areas
%   RETURNS: grayscale processed image of area

%% Initialization
threshold = 155;

%% Area to Check for Bubbles
ymin = min(ybound);
ymax = max(ybound);
rect = [15-dev,ymin-dev,373-15+dev,ymax-ymin+dev];
image_cropped = rgb2gray(imcrop(image,rect));

%% Filtering Cropped Images
image_processed = 230*(image_cropped>threshold);


end

