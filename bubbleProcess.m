function [centroids,perimeters,majorAxisLength] = bubbleProcess( bubbleImage,rawBubbleImage )
%BUBBLEPROCESS FINDS CENTROIDS GIVEN BUBBLE IMAGES 
%   finds centroids in image where all bubbles are filled in
%   computes perimeter and area of centroids based on unfilled image
%   rawBubbleImage: unfilled input image
%   bubbleImage: filled input image to process
debug = false;

%% Find Centroids 
boundary = bwperim(bubbleImage);
s = regionprops(boundary, 'Centroid','Perimeter','MajorAxisLength');

%% Return Outputs
if isfield(s,'Centroid')
    centroids = cat(1, s.Centroid); 
else
    centroids = nan;
end

if isfield(s,'Perimeter')
    perimeters = cat(1, s.Perimeter);
else
    perimeters = nan;
end

if isfield(s,'MajorAxisLength')
    majorAxisLength = cat(1, s.MajorAxisLength);
else
    majorAxisLength = nan;
end
%% Graphical Debugging
if debug == true
    imshow(boundary,'initialMagnification',700)
    hold on
    plot(centroids(:,1),centroids(:,2), 'r*')
    hold off
end
end