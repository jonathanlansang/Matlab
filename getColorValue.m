function [ thresholdColor ] = getColorValue( image )
%GETCOLORVALUE Summary of this function goes here
%   Detailed explanation goes here

figure();
imshow(image)
[x,y] = ginput();
imageToCheck = rgb2gray(image);
for i = 1:length(x) 
    myAvgs(i) = imageToCheck(floor(y(i)),floor(x(i)));
end

thresholdColor = floor(mean(myAvgs));

end

