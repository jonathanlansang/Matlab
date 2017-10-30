function boundaryBoxHelper( ymin,ymax,xmax,xmin,image )
%BOUNDARYBOXHELPER Displays image with box overlay
%   Box shows the gap in between the rods 

figure();
imshow(image);
length = xmax - xmin;
width = ymax - ymin;

box = [xmin,ymin,length,width];
rectangle('Position',box,'EdgeColor','r','LineWidth',1)



end

