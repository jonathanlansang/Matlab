function boundaryBoxHelper( ymin,ymax,image )
%BOUNDARYBOXHELPER Displays image with box overlay
%   Box shows the gap in between the rods 

figure();
imshow(image);
box = [15,ymin,373-15,ymax-ymin];
rectangle('Position',box,'EdgeColor','r','LineWidth',1)


end

