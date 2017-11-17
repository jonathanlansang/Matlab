% Video post processing script to analyse high speed footage of cavitation
% between two parallel discs
% Jonathan Lansang, Marc Krueger-Sprengel 10/13/2017

clear all;
close all;

%% Debugging parameters
debug=false;
playMovie = false;
boxPlotStart = 63;
boxPlotEnd = 250;
fps = 60;

%% Initialize Video
v = uigetdir;
 %loadFrames returns uint8 cell array of each frame
[frames,numFrames] = loadFrames(v);

%% Conversion Rates
dRod = 0.015875;
dRodPx = 358;
sizePx = dRod/dRodPx;
frameRate = 160000;
tFrame = 1/frameRate;

%% Tracking parameters
minLength = 5;
sensitivity = 25;
yTrack = zeros(numFrames,2);
xTrack = zeros(numFrames,2);
checkArea = {zeros(1,numFrames)};

%% Pre-processing parameters 
smoothVel = true;
hasInfoBar = true;
acqRes = [384,128];
hasBubbles = false;

%% Cropping Information Bar
if hasInfoBar == true
    [frames] = cropInfoBar(frames,numFrames,acqRes);
end

%% Tracking Rod
tic
for i = 1:numFrames
    
image = frames{i};

image_edge = edge(rgb2gray(image),'prewitt');
image_filled = imfill(image_edge,'holes');

% image_filled = filterImage(image,2);

[xmin,xmax,ymin,ymax] = findEdges(image_filled,minLength);

yTrack(i,1) = ymin; %position of top rod
yTrack(i,2) = ymax; %position of bottom rod
xTrack(i,1) = xmin; %position of left rod
xTrack(i,2) = xmax; %position of right rod
end
bottomRodPos = mode(yTrack(:,2));
toc
%% Computing X-Coordinate Boundaries
% ASSUME: the rods are bound to the Y-axis
xMin = xTrack(:,1);
xMax = xTrack(:,2);

xMin = xMin(xMin~=0);
xMax = xMax(xMax~=0);

xBound(1) = mode(xMin);
xBound(2) = mode(xMax);

%%  Data smoothing
rawY = yTrack;
yTrack = removeSpikes(yTrack);
yTrack = smoothY(yTrack);

%% Displaying Boundary Box
if debug==true
    [frames_box] = boundaryBoxHelper(yTrack,xBound,frames,boxPlotStart,boxPlotEnd,fps,playMovie); 
    %frames_box: cell that contains individual frames with boundary box
    %superimposed 
end

%% Tracking Cavitations
if hasBubbles == true
tic
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

% POST-PROCESSING
totalBubbleFrames = 0;
framesWithBubble = 1;
k = 2;
for i = 1 : numFrames
    if ~isempty(perimeters{i})
        totalBubbleFrames = totalBubbleFrames + 1;
        framesWithBubble(k) = i;
        k = k + 1;
    end
end
timeBetweenBubbles = diff(framesWithBubble);
toc
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