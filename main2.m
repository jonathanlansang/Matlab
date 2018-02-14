% Video post processing script to analyse high speed footage of cavitation
% between two parallel discs
% Jonathan Lansang, Marc Krueger-Sprengel 10/13/2017

clear all;
close all;
warning off;

%% Debugging parameters
debug=false;
playMovie = true;

boxPlotStart = 220;
boxPlotEnd = 221;
fps = 60;

%% Initialize Video
%v = uigetdir;
 %loadFrames returns uint8 cell array of each frame
v = 'run4.mp4';
[frames,numFrames] = loadFrames(v);

%% Conversion Rates
dRod = 0.015875;
dRodPx = 358;
sizePx = dRod/dRodPx;
frameRate = 160000;
tFrame = 1/frameRate;
density = 1000; %[kg/m^3]
viscosity = 8.9e-4; %[Pa s] for const. visc. water

%% Tracking parameters
minLength = 5;
yTrack = zeros(numFrames,2);
xTrack = zeros(numFrames,2);
checkArea = {zeros(1,numFrames)};

%% Pre-processing Parameters 
smoothVel = true;
hasInfoBar = false;
acqRes = [384,128];
hasBubbles = true;

%% Post-Processing Parameters
numBoxes = 20;
axis = 'x';

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

%% Calculate step positions
steps = findSteps(yTrack);

%% Initial Gap Reprocessing
threshold = 270 - getColorValue(frames{floor(numFrames-1)},yTrack(floor(numFrames-1),:));

firstMove = steps(1,2);

topRod = median(yTrack(1:firstMove));
bottomRod = median(yTrack(1:firstMove,2));

if abs(topRod-bottomRod)<1 || abs(topRod-bottomRod)>10
    for i = 1:firstMove
    [topRodStart(i),bottomRodStart(i)] = findEdges2(frames{i},threshold);
    end
    yTrack(1:steps(1,2),1) = median(topRodStart);
    steps = findSteps(yTrack);
end
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
    [centroid,perimeter,majorAxisLength] = bubbleProcess(bubbleImage);
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
vFraction = {};
for n = 1:numFrames
    vFraction{n} = voidFraction(bubbleFrames{n},numBoxes,axis);
end
toc
end

%% Velocity, pressure and acceleration calculation
interpolationOverlap = 90;
polyFitOrder = 35;

[velocity, acceleration] = velAcc(steps, sizePx, tFrame, smoothVel);

displacementPoly = dispPolyFit(yTrack, steps, numFrames, interpolationOverlap, polyFitOrder);
[velocityPoly, accelerationPoly] = velAccPolyFit(yTrack, steps, sizePx, tFrame, numFrames, interpolationOverlap, polyFitOrder);

[relPressureLeider, relPressureLeiderPolyFit] = relPressureLeider(velocity, steps, velocityPoly, displacementPoly, bottomRodPos, dRod, sizePx, viscosity);
relPressureKuzma = relPressureKuzma(displacementPoly, velocityPoly, accelerationPoly, bottomRodPos, dRod, sizePx, density, viscosity);

reynoldsNumber = reynoldsNumber(displacementPoly, velocityPoly, density, viscosity, sizePx, bottomRodPos);
%% Plotting
% plotDisplacement(numFrames,yTrack,steps,interpolationOverlap, polyFitOrder)
% plotVelocity(velocity, velocityPoly, steps, interpolationOverlap)
% plotAcceleration(acceleration, accelerationPoly, steps, interpolationOverlap)
% plotPressure(relPressureLeider, relPressureLeiderPolyFit, relPressureKuzma, steps, interpolationOverlap)

plotCombined(numFrames, yTrack, steps, velocityPoly, accelerationPoly, reynoldsNumber, relPressureLeiderPolyFit, relPressureKuzma, interpolationOverlap, polyFitOrder);