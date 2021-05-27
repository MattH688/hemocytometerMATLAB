function [bcell]=hemocytometerCellSeg(ROI,D,name)
% https://blogs.mathworks.com/steve/2006/06/02/cell-segmentation/
%https://uk.mathworks.com/help/images/identifying-round-objects.html
%
%
% Method proposed uses the watershed as demonstrated in the MATLAB
% tutorial

%bw2 = imfill(ROI,'holes');
bw1 = imbinarize(ROI,'adaptive');
bw2 = bwareaopen(bw1,90);

[B,L] = bwboundaries(bw2,'noholes');
imshow(label2rgb(L,@jet,[.5 .5 .5]))
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
    % obtain (X,Y) boundary coordinates corresponding to label 'k'
    boundary = B{k};
    % display the results
    metric_string = num2str(k);
    % mark objects above the threshold with a black circle
    text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
        'FontSize',14,'FontWeight','bold')
end

bcell = length(B);

saveas(gcf,[D,'\',name],'fig')
saveas(gcf,[D,'\',name],'png')
close all

%bpImage = bwmorph(binaryImage, 'branchpoints')

% bw3 = imopen(ROI, ones(5,5));
% bw4 = bwareaopen(bw3, 40);
% bw4_perim = bwperim(bw4);
% I_eq = adapthisteq(ROI);
% overlay1 = imoverlay(I_eq, bw4_perim, [.3 1 .3]);
% imshow(overlay1)

