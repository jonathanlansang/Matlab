function [ yTrack,bottomRodPos ] = throwOutliers( frames,yTrack,initialGap,minLength,sensitivity,sigma )
%THROWOUTLIERS Fill in outliers in data set
%   When a value defaults to 0 then we load the previous position
%   The cyclical nature of the edgeFind from frames 0:300 we lower
%   sensitivity and rerun the edgeFind

 dev = 3.5;
 for i = 2:length(yTrack)
     if yTrack(i,2) == 0 || yTrack(i,2) == yTrack(i,1)
         yTrack(i,2) = yTrack(i-1,2);
     end
 end
 
bottomRodPos = mode(yTrack(:,2));

 for i = 2:300
     if abs(yTrack(i,1) - yTrack(i-1,1)) >= dev
        image = frames{round(i)};
        image_prewittGauss = filterImage(image,sigma);
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


end

