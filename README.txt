# Matlab
README describes the purpose and basic details and implementation of each function used within main2

# boundaryBoxHelper.m 
(displays video with superimposed box showing the area between the rods to be analyzed)
  INPUT(yBound,xBound,frames,boxPlotStart,boxPlotEnd,fps,playMovie)
    yBound: array of the maximum and minimum y-coordinates for frames of interest
    xBound: array of the maximum and minimum x-coordinates for frames of interest
    boxPlotStart: specific frame to start video 
    boxPlotEnd: specific frame to end video
    fps: desired frames per second of the output video
    playMove: true/false input which dictates if the video will be played 
  OUTPUT(frames_box)
    frames_box: video with superimposed box showing area between rods 

# bubbleFilter.m
(Fills in pixel 'holes' in images and isolates cavitation bubbles from rods)
  INPUT(image,ybound,xbound,dev,threshold)
    image = uint8 rgb image/frame to process
    ybound = position of top and bottom rod (yTracks)
    xbound = position of left and right edges of rod
    dev = size of added 'buffer' to limits of x and y coordinates (accounts for minor inaccuracies in future programming)
    threshold = "darkness" value we consider to be an object
  OUTPUT: 
  image_processed: binary image of bubbles with the rods
  image_filled: binary image of the bubbles without the rods 
  
# bubbleProcess.m
(finds centroids within the given bubble images)
  INPUT(bubbleImage)
    bubbleImage = binary image of bubbles without the rods 
  OUTPUT:
    centroids: returns numBubblesx2 array of x and y coordinates for each individual centroid
    perimeters:returns numBubblesx1 array of perimeters for each individual centroid
    majorAxisLength:returns numBubblesx1 array of major axis lengths for each individual centroid

# cropInfoBar.m 
(crops information bar from the video in order to isolate the rods)
  INPUT(frames,numFrames,acqRes): 
    frames: cell array of frames to be cropped
    numFrames: number of frames to be cropped(size of frames array)
    acqRes: data obtained from initial video information bar
  OUTPUT:
    frames_cropped: cell array of frames with information bar removed

# dispPolyFit.m

# filterImage.m <NOT IMPLEMENTED>
(filters rgb image which makes the rod edges more distinct)
<Implements Gaussian Blur, Prewitt Edge Finding Algorithm,Line Dilation, and Hole Filling>
  INPUT(image,sigma):
    image =  rgb image to be processed (raw image taken from video)
    sigma = magnitude of Gaussian Blur (0:2)
  OUTPUT:
    image_prewittGauss: BW processed image 
    
# findEdges.m
(finds left/right and top/bottom edge coordinates of rods using Hough Transformations)
<Hough Transformation looks for the straightest lines of a defined angle theta>
  INPUT(image,minLength):
    image = binary pre-processed image
    minLength = minimum pixel length to consider when finding the straightest lines in the image
  OUTPUT:
    xmin: leftmost x-coordinate of rod
    xmax: rightmost x-coordinate of rod
    ymin: bottommost y-coordinate of rod
    ymax: topmost y-coordinate of rod
  
# findEdges2.m <NOTE: process time is greater than that of findEdges.m (use only where findEdges.m is inaccurate)>
(uses threshold value to generate binary rod image and finds the first instance of 0 in each column to determine y-coordinate of rod)
  INPUT(image,threshold):
    image = raw image from frame to be processed
    threshold = grayscale value to determine 'darkness' of bubbles (see getColor.m)
  OUTPUT:
    topRodY2: topmost y-coordinate of rod
    bottomRodY2: bottommost y-coordinate of rod
# findSteps.m
(finds frames that the bar moved a number of pixels relative to the previous position)
  INPUT(yTrack):
    yTrack: array containing top rod y-coordinates for the entire video
  OUTPUT:
    steps: array with the form [number of pixels moved, frame of occurance] for entire video 
    
# getColorValue.m
(finds the grayscale value corresponding to the liquid <therefore we can isolate the liquid from the bubbles>)
  INPUT(image,yTracks):
    image = raw image from frame to be processed
    yTracks = array containing rod y-coordinates with form [ymin,ymax] for specific image to be processed
  OUTPUT:
    thresholdColor = grayscale value that defines the 'color' value of the specific liquid given the lighting in the video (0:270)

# loadFrames.m
(loads individual frames into uint8 format cell)
  INPUT(video):
    video: video to load frames from
  OUTPUT: 
    frames: cell array of images taken from frames
    numFrames: total number of frames for inputted video
# main2.m
  <RUNNER>
  
# mainMultiVideo.m <NOT IMPLEMENTED>
(creates plots of rod position over time for multiple video sources)
  
# outline3.m <NOT IMPLEMENTED>
(first draft of program)

# plotAcceleration.m
# plotPressure.m
# plotVelocity.m
# relPressureKuzma.m
# relPressureLeider.m

# removeSpikes.m
(Removes single value extreme upticks and downticks from position of top and bottom rod)
  INPUTS(yTrack)
    yTrack = array containing top and bottom rod y-coordinates for the entire video in the form: [topRod,bottomRod]
  OUTPUTS:
    yTrack = input with the 'spikes' removed
# reynoldsNumber.m

# smoothY.m
(removes any medium negative extrema under the assumption that only allows the positive top bar velocity)
  INPUTS(yTrack)
    yTrack = array containing top and bottom rod y-coordinates for the entire video in the form: [topRod,bottomRod]
  OUTPUTS:
    yTrack = input with the negative extrema removed
# throwOutliers.m <NOT IMPLEMENTED>
(Fill in outliers in data set)
<When a value defaults to 0 then we load the previous position...
  The cyclical nature of the edgeFind from beginning frames, we lower sensitivity and rerun the findEdges.m>
  INPUT(frames,yTrack,initialGap,minLength,sensitivity,sigma):
    frames: cell array of frames
    yTrack: array containing top and bottom rod y-coordinates for the entire video in the form: [topRod,bottomRod]
    initialGap: minimum allowable initial gap height (pixels)
    minLength: minimum length to consider rod 
    sensitivity: sensitivity of the findEdge.m algorithm
    sigma: magnitude of Gaussian Blur (0:2)
  OUTPUT:
  yTrack: new input with the extrema reprocessed
  bottomRodPos: scalar fixed value of bottom rod y-coordinate
 
# velAcc.m
# velAccPolyFit.m
