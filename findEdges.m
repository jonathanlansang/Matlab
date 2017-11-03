function [xmin,xmax,ymin,ymax] = findEdges(image,minLength)
%% FUNCTION FINDS EDGES USING HOUGH TRANSFORMATIONS
%   image: BW preprocessed image

%% Initialization
xbound = 0;
ybound = 0;

%% Hough Transformation
[H,theta,rho] = hough(image);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(image,theta,rho,P,'FillGap',5,'MinLength',minLength);

%% Finding X & Y Lines
for i = 1:length(lines)
    
    if lines(i).point1(2) == lines(i).point2(2)
        ybound(i) = lines(i).point1(2);
        ybound = ybound(ybound ~= 0);
    end
    
    if lines(i).point1(1) == lines(i).point2(1)
        xbound(i) = lines(i).point1(1);
        xbound = xbound(xbound ~= 0);
    end
end
 %% Finding X & Y Maxima/Minima

xmax = max(xbound);
xmin = min(xbound);
ymax = max(ybound); %larger y values are lower on the image
ymin = min(ybound);

