% Video post processing script to analyse high speed footage of cavitation
% between two parallel discs
% Jonathan Lansang, Marc Krueger-Sprengel 10/13/2017

clear all
close all
hold on

%% Debugging parameters
debug=false;
boxPlotStart = 1;
boxPlotEnd = 200;
fps = 50;

%% Initialize Multiple Videos
videoNames = {'run10_noWeight_maxHeight_stabilized_newLever.mp4'...
    ,'run9_noWeight_maxHeight_stabilized_newLever.mp4'...
    , 'run8_noWeight_maxHeight_stabilized_newLever.mp4'};

for p = 1:length(videoNames)  
%% Video file input
v = videoNames{p};
[frames,numFrames] = loadFrames(v); %loadFrames returns int8 cell array of each frame

%% Initialization and Parameter input
dRod = 0.015875;
dRodPx = 358;
sizePx = dRod/dRodPx;
frameRate = 160000;
tFrame = 1/frameRate;

% Tracking parameters
step = 0.00; % sensitivity deviation
sigma = 0.1; % magnitude of Gaussian blur
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

%% Calculate step positions
steps = findSteps(yTrack);    

%% Plotting
plot((1:numFrames),yTrack(:,1)); % top rod
plot((1:numFrames),yTrack(:,2)); % bottom rod
scatter(steps(:,2),steps(:,1));

end

legend(strcat(videoNames{1},'(Top)'),...
    strcat(videoNames{1},'(Bottom)'),...
    strcat(videoNames{1},'(Steps)'),...
    strcat(videoNames{2},'(Top)'),...
    strcat(videoNames{2},'(Bottom)'),...
    strcat(videoNames{2},'(Steps)'),...
    strcat(videoNames{3},'(Top)'),...
    strcat(videoNames{3},'(Bottom)'),...
    strcat(videoNames{3},'(Steps)'));
hold off
