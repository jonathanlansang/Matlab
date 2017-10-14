function [ image_prewittGauss ] = filterImage( image,sigma )
%FILTERIMAGE filters uint8 image to rgb edge outline
%   Each filtering process described below

% Gaussian Blur 
image_gauss = rgb2gray(imgaussfilt(image,sigma));

% Prewitt Edge Finding Algorithm
image_prewittGauss = edge(image_gauss,'prewitt');

% Dilate Lines Left After Prewitt 
image_prewittGauss = imdilate(image_prewittGauss,strel('line',20,0));

% Morphological Element that fills holes 
image_prewittGauss = bwmorph(image_prewittGauss,'thin',inf);

end

