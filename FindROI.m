function [ROI, cropVal, BWex2] = FindROI(I)
%% Remove non uniform illumination to improve detection of hemaocyte grid
% Based off https://uk.mathworks.com/help/images/correcting-nonuniform-illumination.html
%
% Exported are region of interest (ROI), range of mask in X and Y (cropVal)
%   for image crop and binary image of mask (BWex2) to find cells within
%
% Optimised by Dr. Matthew Hockley (UoK 2019-present) for 10x microscope
%   lens for Hemaocyte cell counts

%I = rgb2gray(rotI);
%% Find background
se = strel('disk',35); % Set sampling size
background = imopen(I,se); % Apply to image

%% Remove background and adjust image brightness and contrast
I2 = I - background;
I3 = imadjust(I2);

%% Remove noise from image
bw = imbinarize(I3); % Convert to binary image
bw = bwareaopen(bw,50); % Remove small background noise
%imshow(bw)

%% Erode smaller squares to find larger square boundary

% Make lines thicker on boxes (incase BG removal)
se = strel('line',5,90);
BW2 = imdilate(bw,se);
se = strel('line',5,0);
BW2 = imdilate(BW2,se);
%imshow(BW2)

% Erode smaller cells

% se = strel('disk',5);
% erodedBW = imerode(bw,se);
se = strel('disk',8);
erodedBW = imerode(BW2,se);
%imshow(erodedBW)

%% Extract square to measure cell counts within
BWneg = imcomplement(erodedBW); % Invert image
BWex = bwareafilt(BWneg,2); % Find 2 largest areas
BWex2 = bwareafilt(BWex,1,'smallest'); % find second largest area
BWex2 = imfill(BWex2,'holes'); % Fill any gaps within the image
%imshow(BWex2) % Present second largest image boundary

%% Crop to ROI (region of interest)
%ROI = I;
%ROI(BWex2 == 0) = 0; % Use BWex2 as mask for I image
[row, col] = find(BWex2 == 1); % Find edges of mask
minX = min(row);minY = min(col);maxX = max(row);maxY = max(col);
ROI = I(minX:maxX,minY:maxY); % Apply mask limits to crop image
imshow(ROI); % Present crop area on the greyscale image
cropVal = {[minX:maxX];[minY:maxY]}; % Save crop region
