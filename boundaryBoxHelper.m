function boundaryBoxHelper( ymin,ymax,image )
%BOUNDARYBOXHELPER Displays image with box overlay
%   Box shows the gap in between the rods 

figure();
imshow(image);
rectangle('Position',[15,ymax,373-15,ymax-ymin],'EdgeColor','r','LineWidth',1)


end

