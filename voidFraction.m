function [ ratio ] = voidFraction(bubbleFrame,numBoxes,axis )
%voidFraction finds ratio of bubbles to liquid in the n = numSections sections
%of the area in between the two rods

[height,width] = size(bubbleFrame);

ratio = zeros(1,numBoxes);

switch upper(axis)
    case 'X'
        split = floor(width/numBoxes);
        endDiff = width - numBoxes*split;
        for n = 0:numBoxes-2
            frameToAnalyze = bubbleFrame(:,n*split+1:(n+1)*split);
            bubbles = sum(frameToAnalyze(:));
            totalArea = numel(frameToAnalyze);
            ratio(n+1) = bubbles/totalArea;
        end
        frameToAnalyze = bubbleFrame(:,(numBoxes-1)*split:(numBoxes*split)+endDiff);
        bubbles = sum(frameToAnalyze(:));
        totalArea = numel(frameToAnalyze);
        ratio(numBoxes) = bubbles/totalArea;
        
    case 'Y'
        split = floor(height/numBoxes);
        endDiff = height - numBoxes*split;
        for n = 0:numBoxes-2
            frameToAnalyze = bubbleFrame(n*split+1:(n+1)*split,:);
            bubbles = sum(frameToAnalyze(:));
            totalArea = numel(frameToAnalyze);
            ratio(n+1) = bubbles/totalArea;
        end
        frameToAnalyze = bubbleFrame((numBoxes-1)*split:(numBoxes*split)+endDiff,:);
        bubbles = sum(frameToAnalyze(:));
        totalArea = numel(frameToAnalyze);
        ratio(numBoxes) = bubbles/totalArea;
    otherwise 
        ratio = [];
end
        
    

end

