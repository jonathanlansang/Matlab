function [image_processed, image_filled] = bubbleFilter( image,ybound,xbound,dev,threshold )
%BUBBLEFILTER Preprocessing bubble image frames
%   image = uint8 rgb image/frame to process
%   ybound = yTracks; % position of top and bottom rod
%   dev = pixel buffer between tracking areas
%   threshold = "darkness" we consider to be an object
%   RETURNS: BW image of the centroids without the rods 

debug = false;

%% Rough Area to Check for Bubbles
ymin = min(ybound);
ymax = max(ybound);
xmin = min(xbound);
xmax = max(xbound);

bottomLx = xmin-dev ;
bottomLy = ymin-dev ;
height = ymax-ymin+dev;
width = xmax-xmin+dev;

image = rgb2gray(image);
rect = [bottomLx,bottomLy,width,height];
rough_image_cropped = (imcrop(image,rect));

%% Filtering Cropped Images
image_processed = (rough_image_cropped<threshold);
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

%% Filtering Cropped Images
% THIS SECTION REMOVES THE RODS AND DISPLAYS ONLY THE REMAINING CENTROIDS

image_filled = (image_filled);
for i = 1:xRange
    for j = 1 : topRodY(i)
        image_filled(j,i) = false;
    end
    for k = 1 : bottomRodY(i)
        image_filled(yRange-k+1,i) = false;
    end
end

%% Plotting Edge Trimming Area
if debug == true
    figure();
    imshow(double(image_filled),'initialmagnification',700)
    hold on
    plot([1:xRange],topRodY,'linewidth',1.5)
    plot([1:xRange],yRange-bottomRodY+1,'linewidth',1.5)
end

end

