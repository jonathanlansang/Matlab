function outline3()

warning off;
%% Conversion Rates 
% Rod Diameter = 5/8"(0.015875m)

%% Initialization
step = 0.00; % sensitivity deviation
sigma = 2; % magnitude of Gaussian blur
framesAnalyze = 10;
minLength = 30;
sensitivity = 28;
initialGap = 3;
yTrack = zeros(framesAnalyze,2);

v = 'run5_newLight_gap.mov';
%loadFrames returns int8 cell array of each frame
[frames,numFrames] = loadFrames(v); 

 for i = 1: numFrames
     
%% Filtering Frames
image = frames{round(i)};

image_gauss = rgb2gray(imgaussfilt(image,sigma));
image_prewittGauss = edge(image_gauss,'prewitt');
image_prewittGauss = imdilate(image_prewittGauss,strel('line',20,0));
image_prewittGauss = bwmorph(image_prewittGauss,'thin',inf);

% plotZ(image_gauss,image_prewitt,image_prewittGauss)

%% Finding Edges 
[xmin,xmax,ymin,ymax] = findEdges(image_prewittGauss,minLength);

% %% Plot Rectangles 
% figure();
% imshow(image);
% rectangle('Position',[15,ymax,373-15,ymax-ymin],'EdgeColor','r')

%% Input X & Y Max/Min
yTrack(i,1) = ymin; %position of top rod
yTrack(i,2) = ymax; %position of bottom rod
% xMin(i,1) = xmin;
% xMax(i,1) = xmax;
% realXMin = mean(abs(xMin));
% realXMax = mean(abs(xMax));

 end
 
 %% Fill in null Values in Rod Position
 dev = 3.5;
 for i = 2:length(yTrack)
     if yTrack(i,2) == 0 || yTrack(i,2) == yTrack(i,1)
         yTrack(i,2) = yTrack(i-1,2);
     end
 end
 
bottomRodPos = median(yTrack(:,2));

 for i = 2:300
     if abs(yTrack(i,1) - yTrack(i-1,1)) >= dev
        image = frames{round(i)};
        image_gauss = rgb2gray(imgaussfilt(image,sigma));
        image_prewittGauss = edge(image_gauss,'prewitt');
        image_prewittGauss = imdilate(image_prewittGauss,strel('line',20,0));
        image_prewittGauss = bwmorph(image_prewittGauss,'thin',inf);
        
        [xmin,xmax,ymin,ymax] = findEdges(image_prewittGauss,minLength-sensitivity);
        yTrack(i,1) = ymin;
     end
     
     if  abs(yTrack(i,1)-bottomRodPos) <= dev
        yTrack(i,1) = yTrack(i,1) - initialGap; 
     end
 end

for i = 300:length(yTrack)
    if yTrack(i,1) == 0 || abs(yTrack(i,1) - yTrack(i-1,1)) >= dev || yTrack(i,1)== bottomRodPos

        yTrack(i,1) = yTrack(i-1,1);
    end
end

 %% Fit an n-degree Polynomial to Top rod position
n = 20;
 x = linspace(1,numFrames,length(yTrack));
coeff = polyfit(transpose(x),yTrack(:,1),n);

%% Calculate Positions (Rod and Steps)
j = 1;

for i = 2:length(yTrack)
    if yTrack(i,1) ~= yTrack(i-1,1)
        steps(j,1) = yTrack(i,1); %step pixel #
        steps(j,2) = i; %step frame #
        j = j + 1;
    end
end
figure();
deltaY = yTrack(:,2) - yTrack(:,1);
space = linspace(1,numFrames,length(yTrack));
hold on
plot(space,yTrack(:,1))
plot(space,yTrack(:,2)) %position of bottom rod
% plot(space,bottomRodPos * ones(1,length(yTrack)));
%plot(space,-deltaY); %pixels between rods
fitCurve = polyval(coeff,space);
plot(space,fitCurve)
scatter(steps(:,2),steps(:,1))
xlabel('Frame')
ylabel('Number of Pixels')
legend('Step Positions','Position of top rod')
hold off


% %% Calculate Velocity
% delta_StepX = gradient(steps(:,2));
% delta_StepY = gradient(steps(:,1));
% 
% velocity = delta_StepY / delta_StepX;
% velocity = velocity(:,23);
% accel = velocity/delta_StepX;
% accel = accel(:,23);
% 
% figure();
% hold on;
% plot(steps(:,2),velocity);
% plot(steps(:,2),accel);
% hold off;
% %% Display Position Tracking Outputs
% figure();
% subplot('Position',[0.02 0.35 0.3 0.3]);
% hold on;
% plot(space,yTrack(:,1))
% scatter(steps(:,2),steps(:,1))
% xlabel('Frames')
% ylabel('Number of Pixels')
% legend('Position of Top Rod','Changes(Pixels/Frames)')
% hold off;
% subplot('Position',[0.35 0.35 0.3 0.3]);
% plot(space,fitCurve)
% xlabel('Frames')
% ylabel('Number of Pixels')
% legend('n-degree polynomial approximation')
% subplot('Position',[0.68 0.35 0.3 0.3]);
% hold on;
% plot(space,yTrack(:,1))
% plot(space,yTrack(:,2)) %position of bottom rod
% hold off;
% legend('Position of Top Rod','Position of Bottom Rod')
% xlabel('Frames')
% ylabel('Pixels')
% linkaxes;
% %% Display Velocity and Accleration Calculations
% 
% figure();
% subplot('Position',[0.1 0.35 0.35 0.35]);
% plot(steps(:,2),velocity)
% xlabel('Frames')
% ylabel('Velocity(Pixels/Frame)')
% legend('Velocity')
% subplot('Position',[0.6 0.35 0.35 0.35]);
% plot(steps(:,2),accel)
% xlabel('Frames')
% ylabel('Acceleration(Pixels/Frame^2)')
% legend('Acceleration')
% 
% linkaxes;
% 
% %% Data Charts
% T = table(steps(:,2),velocity,accel,'VariableNames',{'Frame','Velocity','Acceleration'})
% bottomPos = median(yTrack(:,2));
% end