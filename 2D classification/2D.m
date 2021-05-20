ImagesPath = fullfile('K:','ML for mechanics');
%% Read the Images
Images = imageDatastore(ImagesPath, ...
            'IncludeSubfolders',true,'LabelSource','foldernames');
%% Lable Count
labelCount = countEachLabel(Images);
%% Training Dataset
numTrainFiles = 0.75;
%% Image Size
Image = readimage(Images,1);
size(Image);
[imdsTrain,imdsValidation] =     splitEachLabel(Images,numTrainFiles,'randomize');
%% Layers
layers = [
        imageInputLayer([100 100 3])
        
        convolution2dLayer(3,8,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)
        
        convolution2dLayer(3,16,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)
        
        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)
        
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer];
%% Training Options
options = trainingOptions('sgdm', ...
             'InitialLearnRate',0.01, ...
             'MaxEpochs',2, ...
             'Shuffle','every-epoch', ...
             'ValidationData',imdsValidation, ...
             'ValidationFrequency',30, ...
             'Verbose',false, ...
             'Plots','training-progress');
%% Train Network Using Training Data 
net = trainNetwork(imdsTrain,layers,options);
%% Validation accuracy
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation);
