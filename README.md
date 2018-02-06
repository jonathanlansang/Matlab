# Matlab
README describes the purpose and basic details and implementation of each function used within main2

boundaryBoxHelper.m (displays video with superimposed box showing the area between the rods to be analyzed)
  INPUT(yBound,xBound,frames,boxPlotStart,boxPlotEnd,fps,playMovie)
    yBound: array of the maximum and minimum y-coordinates for frames of interest
    xBound: array of the maximum and minimum x-coordinates for frames of interest
    boxPlotStart: specific frame to start video 
    boxPlotEnd: specific frame to end video
    fps: desired frames per second of the output video
    playMove: true/false input which dictates if the video will be played 
  OUTPUT(frames_box)
    frames_box: video with superimposed box showing area between rods 

bubbleFilter.m
bubbleProcess.m

cropInfoBar.m (crops information bar from the video in order to isolate the rods)
  INPUT(frames,numFrames,acqRes): 
    frames: cell array of frames to be cropped
    numFrames: number of frames to be cropped(size of frames array)
    acqRes: data obtained from initial video information bar
  OUTPUT:
    frames_cropped: cell array of frames with information bar removed

dispPolyFit.m
filterImage.m
findEdges.m
findEdges2.m
getColorValue.m
main2.m
mainMultiVideo.m
outline3.m
plotAcceleration.m
plotPressure.m
plotVelocity.m
relPressureKuzma.m
relPressureLeider.m
removeSpikes.m
reynoldsNumber.m
smoothY.m
throwOutliers.m
velAcc.m
velAccPolyFit.m
