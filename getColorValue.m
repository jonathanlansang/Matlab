function [ thresholdColor ] = getColorValue( image,yTracks )
%GETCOLORVALUE Summary of this function goes here
%   Detailed explanation goes here
% 
% figure();
% imshow(image)
% [x,y] = ginput();
% imageToCheck = rgb2gray(image);
% for i = 1:length(x) 
%     myAvgs(i) = imageToCheck(floor(y(i)),floor(x(i)));
% end
% 
% thresholdColor = floor(mean(myAvgs));

topRodPos = yTracks(1);
bottomRodPos = yTracks(2);
midpoint = mean([topRodPos,bottomRodPos]);
[y,x] = size(image);
thresholdColor = median(image(midpoint,1:x));


end

