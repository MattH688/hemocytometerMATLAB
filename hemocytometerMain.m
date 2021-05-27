function hemocytometerMain
%% Count number of cells in hemocytometer grid(s)
% Based off https://uk.mathworks.com/help/images/correcting-nonuniform-illumination.html
%
% Created by Dr. Matthew Hockley (UoK 2019-present) for 10x microscope
%   lens for Hemaocyte cell counts

%% Import all files from directory
dilution = 6;
D = uigetdir; % Get directory
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.

for k = 1:numel(S) % for length of all pictures in directory
    F = fullfile(D,S(k).name);
    RGB = imread(F);
    I = rgb2gray(RGB);
    % Store images as double (for operations later)
    S(k).data = double(I); % optional, save data.
    
    %% Find ROI to measure cells within
    [ROI, cropVal, BWex2] = FindROI(I); % Export mask
    [S(k).cellcount] = hemocytometerCellSeg(ROI,D,(S(k).name(1:end-4))); % Cell Count
        
    Cellcount(k) = S(k).cellcount;
    
    if k == numel(S)
        avgB = mean(Cellcount);
        Cellcount(2,1) = avgB;
        Cellcount(3,1) = avgB*10000*dilution;
        T = array2table(Cellcount);
        writetable(T,[D,'/CellCount' num2str(round(avgB)) '.xlsx'])
        %xlswrite([D,'/CellCount' num2str(round(avgB)) '.xlsx'],Cellcount,'RawCellCounts');
    end
%     ROI = imflatfield(ROI,30); % Cleans up image
%     %BWs = edge(ROIimadj,'log',0.004)
%     se90 = strel('line',3,90);
%     se0 = strel('line',3,0);
%     BWsdil = imdilate(BWs,[se90 se0]);
%     imshow(BWsdil)
%     figure;imshow(ROI);
end
