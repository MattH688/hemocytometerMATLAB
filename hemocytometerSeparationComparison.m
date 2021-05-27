function hemocytometerSeparationComparison
%% Count number of cells in hemocytometer grid(s)
% Based off https://uk.mathworks.com/help/images/correcting-nonuniform-illumination.html
%
% Created by Dr. Matthew Hockley (UoK 2019-present) for 10x microscope
%   lens for Hemaocyte cell counts

%% Import all files from directory
D = uigetdir; % Get directory where all folders are present
files = dir(D);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

subFolders(1:2) = []; % Remove . and ..

for k = 1:numel(subFolders) % for length of all pictures in directory
    MidPos = strfind(subFolders(k).name,'ul');
    CompName(k,1) = str2double(subFolders(k).name(1:MidPos-1)); % -1 as u
    CompSep(k,1) = (subFolders(k).name(MidPos+2:end)); % +2 as ul  
end

kAdd = 1;
for k = 1:(numel(subFolders)/2)
    k = k*kAdd; %Assuming in pairs 
    NamePos = find(CompName(k,1) == CompName(:,1));
    for i = 1 : length(NamePos)
        CellsPerMl(k,1) = CompName(k,1);
        if CompSep(NamePos(i),1) == 'I' %= Inner
            CellsPerMl(k,2) = XlsCellMl([D, '\', subFolders(NamePos(i)).name]);
        else % O = Outer
            CellsPerMl(k,3) = XlsCellMl([D, '\', subFolders(NamePos(i)).name]);
        end
    end
    kAdd = 2;
end


CellsPerMl( ~any(CellsPerMl,2), : ) = []; % Remove zero rows

% Calculate ratios

for k = 1 : size(CellsPerMl,1)
    CellsPerMl(k,4) = CellsPerMl(k,2)/CellsPerMl(k,3);
    
end

% Save plot and export Excel sheet
CellsPerMl = sortrows(CellsPerMl);
plot(CellsPerMl(:,1),CellsPerMl(:,4))
xlabel('Flow Rate (ul/min)') 
ylabel('Ratio (Inner to Outer n:1)')
saveas(gcf,[D,'\CellRatio'],'fig')
saveas(gcf,[D,'\CellRatio'],'png')

T = array2table(CellsPerMl);
writetable(T,[D,'/CellsPerMl.xlsx'])



end

function [CellsPerMl] = XlsCellMl(FileDir)
CellsPerMl = [];
% Assumes only one excel in document
S = dir(fullfile(FileDir,'*.xlsx'));
T = readtable([FileDir,'\',S(1).name]);
C = table2cell(T);
CellsPerMl = C{3,1};
end
