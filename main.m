% Video post processing script to analyse high speed footage of cavitation
% between two parallel discs
% Jonathan Lansang, Marc Krueger-Sprengel 10/13/2017

clear all;
close all;

%% Video file input
v = 'run10_noWeight_maxHeight_stabilized_newLever.mp4';
[frames,numFrames] = loadFrames(v); %loadFrames returns int8 cell array of each frame

%% Debugging parameters
debug=true;
boxPlotStart = 1;
boxPlotEnd = 200;
fps = 50;

%% Initialization and Parameter input
dRod = 0.015875;
dRodPx = 358;
sizePx = dRod/dRodPx;
frameRate = 160000;
tFrame = 1/frameRate;


% Tracking parameters
step = 0.00; % sensitivity deviation
sigma = 2; % magnitude of Gaussian blur
framesAnalyze = numFrames;
minLength = 30;
sensitivity = 25;
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
image = (frames{i});

image_prewittGauss = filterImage(image,sigma);
[xmin,xmax,ymin,ymax] = findEdges(image_prewittGauss,minLength);

yTrack(i,1) = ymin; %position of top rod
yTrack(i,2) = ymax; %position of bottom rod
xTrack(i,1) = xmin; %position of left rod
xTrack(i,2) = xmax; %position of right rod

end

xMin = xTrack(:,1);
xMax = xTrack(:,2);

xMin = xMin(xMin~=0);
xMax = xMax(xMax~=0);

xBound(1) = mode(xMin);
xBound(2) = mode(xMax);

%% Displaying Boundary Box
if debug==true
    %CODE HELPER for box plotting
    [frames_box] = boundaryBoxHelper(yTrack,xBound,frames,boxPlotStart,boxPlotEnd,fps); 
    %frames_box: cell that contains individual frames with boundary box
    %superimposed 
end
%% Data smoothing
[yTrack,bottomRodPos] = throwOutliers(frames,yTrack,initialGap,minLength,sensitivity,sigma);
yTrack = removeSpikes(yTrack);

% %% Tracking Cavitations
% % INITIALIZATION
% threshold = 150;
% dev = 5;
% bubbleFrames = {zeros(1,numFrames)};
% rawBubbleFrames = {zeros(1,numFrames)};
% centroidLocations = {zeros(1,numFrames)};
% perimeters = {zeros(1,numFrames)};
% majorAxisLengths = {zeros(1,numFrames)};
% % PROCESSING
% 
% for i = 1: numFrames
%     image = frames{i};
%     [rawBubbleImage, bubbleImage] = bubbleFilter(image,yTrack(i,:),xBound,dev,threshold);
%     bubbleFrames{i} = bubbleImage;
%     rawBubbleFrames{i} = rawBubbleImage;
%     % TODO: find area and frequency of bubbles (POST-PROCESSING)
%     [centroid,perimeter,majorAxisLength] = bubbleProcess(bubbleImage,rawBubbleImage);
%     centroidLocations{i} = centroid;
%     perimeters{i} = perimeter;
%     majorAxisLengths{i} = majorAxisLength;
% end

%% Calculate step positions
steps = findSteps(yTrack);

%% Velocity, pressure and acceleration calculation
[velocity, acceleration] = velAcc(steps, sizePx, tFrame, smoothVel);
relPressure = relPressure(velocity,steps,bottomRodPos,dRod,sizePx);

%% Plotting
plotDisplacement(numFrames,yTrack,steps)
plotVelocity(velocity)
plotPressure(relPressure)
