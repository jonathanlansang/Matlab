% Video post processing script to analyse high speed footage of cavitation
% between two parallel discs
% Jonathan Lansang, Marc Krueger-Sprengel 10/13/2017

clear all;
close all;

%% Debugging parameters
debug=false;
boxPlotStart = 400;
boxPlotEnd = 500;

%% Initialization and Parameter input
dRod = 0.015875;
dRodPx = 358;
sizePx = dRod/dRodPx;
frameRate = 160000;
tFrame = 1/frameRate;

%Video file input
v = 'run6_maxWeight_maxHeight_stabilized_newLever.mp4';
[frames,numFrames] = loadFrames(v); %loadFrames returns int8 cell array of each frame

% Tracking parameters
step = 0.00; % sensitivity deviation
sigma = 2; % magnitude of Gaussian blur
framesAnalyze = numFrames;
minLength = 30;
sensitivity = 20;
initialGap = 3;
yTrack = zeros(framesAnalyze,2);
xTrack = zeros(framesAnalyze,2);
smoothVel = true;
hasInfoBar = true;
acqRes = [384,128];

%% Cropping the Information Bar

if hasInfoBar == true
    [frames] = cropInfoBar(frames,numFrames,acqRes);
end

%% Tracking Rod
for i = 1:numFrames
image = frames{round(i)};

image_prewittGauss = filterImage(image,sigma);
[xmin,xmax,ymin,ymax] = findEdges(image_prewittGauss,minLength);

if debug==true
    boundaryBoxHelper(ymin,ymax,image) %CODE HELPER for box plotting
end

yTrack(i,1) = ymin; %position of top rod
yTrack(i,2) = ymax; %position of bottom rod
xTrack(i,1) = xmin; %position of left rod
xTrack(i,2) = xmax; %position of right rod

end

xBound(1) = median(xTrack(:,1));
xBound(2) = median(xTrack(:,2));

%% Data smoothing
[yTrack,bottomRodPos] = throwOutliers(frames,yTrack,initialGap,minLength,sensitivity,sigma);
yTrack = removeSpikes(yTrack);

%% Tracking Cavitations
% INITIALIZATION
threshold = 150;
dev = 5;
bubbleFrames = {zeros(1,numFrames)};
rawBubbleFrames = {zeros(1,numFrames)};
centroidLocations = {zeros(1,numFrames)};
perimeters = {zeros(1,numFrames)};
majorAxisLengths = {zeros(1,numFrames)};
% PROCESSING

for i = 1: numFrames
    image = frames{i};
    [rawBubbleImage, bubbleImage] = bubbleFilter(image,yTrack(i,:),xBound,dev,threshold);
    bubbleFrames{i} = bubbleImage;
    rawBubbleFrames{i} = rawBubbleImage;
    % TODO: find area and frequency of bubbles (POST-PROCESSING)
    [centroid,perimeter,majorAxisLength] = bubbleProcess(bubbleImage,rawBubbleImage);
    centroidLocations{i} = centroid;
    perimeters{i} = perimeter;
    majorAxisLengths{i} = majorAxisLength;
end




%% Calculate step positions
steps = findSteps(yTrack);

%% Velocity, pressure and acceleration calculation
[velocity, acceleration] = velAcc(steps, sizePx, tFrame, smoothVel);
relPressure = relPressure(velocity,steps,bottomRodPos,dRod,sizePx);

%% Plotting
plotDisplacement(numFrames,yTrack,steps)
plotVelocity(velocity)
plotPressure(relPressure)
