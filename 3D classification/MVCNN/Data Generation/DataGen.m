%% Specify the folder where the files live.
Folders = ["BOLTS AND SCREW", "BOLT"; "NUTS", "NUT"; "Gears", "GEAR"; "WASHER", "WASHER"]
ClassName = ['BOLT', 'NUT', 'GEAR', 'WASHER'];
%% Check to make sure that folder actually exists.  Warn user if it doesn't.
% if ~isfolder(myFolder)
%     errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
%     uiwait(warndlg(errorMessage));
%     myFolder = uigetdir(); % Ask for a new one.
%     if myFolder == 0
%          % User clicked Cancel
%          return;
%     end
% end

%% Define azimuthal and elevation angles
az = [0;15;30;45;60;75;90];
%% Delete previous dataset folder and make new folder to store images of stl files
dataset = '/MATLAB Drive/dataset';
if isfolder(dataset)
    rmdir(dataset, 's')
end
mkdir(dataset);
csv = '/MATLAB Drive/train.csv';
delete(csv);
%%  Creating csv file
M = ["part_no", "class"];
j = 10;
%% Code to capture views of stl files
for fol=1:4
    class = Folders(fol, 2)
    Folder = Folders(fol, 1)
    myFolder = '/MATLAB Drive/' + Folder;
    %% Get a list of all files in the folder with the desired file name pattern.
    filePattern = fullfile(myFolder, '*.stl'); % Change to whatever pattern you need.
    theFiles = dir(filePattern);
    for i=1:length(theFiles)
        baseFileName = theFiles(i).name;
        [pathstr, name, ext] = fileparts(baseFileName);
        fullFileName = fullfile(theFiles(i).folder, baseFileName);
        fprintf(1, 'Now reading %s\n', fullFileName);
        model = stlread(fullFileName);
        figure('visible','off');
        style = 'mesh';
        for vp=1:8
            if (vp == 7) 
                plotMesh(model, style, 0, 90);
            elseif (vp == 8)
                plotMesh(model, style, 0, -90);
            else
                plotMesh(model, style, az(vp), 30);
            end
            im = print('-RGBImage', '-r100');
   
            figureName = "A" + int32(j) + "_" + sprintf("%02d", vp) + ".png";
            im = resize_im(im, 224, 0.1, 0.3);
            imwrite(im, fullfile(dataset, figureName),'WriteMode','append');
        end  
        M = [M; "A" + int32(j) class];
        j = j + 10;
    end
end
j
writematrix(M,'train.csv','WriteMode','append');
function im = resize_im(im,outputSize,minMargin,maxArea)

max_len = outputSize * (1-minMargin);
max_area = outputSize^2 * maxArea;

nCh = size(im,3);
mask = ~im2bw(im,1-1e-10);
mask = imfill(mask,'holes');
% blank image (all white) is outputed if not object is observed
if isempty(find(mask, 1)),
    im = uint8(255*ones(outputSize,outputSize,nCh));
    return;
end
[ys,xs] = ind2sub(size(mask),find(mask));
y_min = min(ys); y_max = max(ys); h = y_max - y_min + 1;
x_min = min(xs); x_max = max(xs); w = x_max - x_min + 1;
scale = min(max_len/max(h,w), sqrt(max_area/sum(mask(:))));
patch = imresize(im(y_min:y_max,x_min:x_max,:),scale);
[h,w,~] = size(patch);
im = uint8(255*ones(outputSize,outputSize,nCh));
loc_start = floor((outputSize-[h w])/2);
im(loc_start(1)+(0:h-1),loc_start(2)+(0:w-1),:) = patch;

end


