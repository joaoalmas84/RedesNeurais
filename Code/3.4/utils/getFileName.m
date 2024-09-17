function [filename]=getFileName(config)
    tFcns=getTFcns(config);
    
    filename = config.nomeDataset;
    filename = sprintf('%s, %d',filename,size(config.hiddenLayers,2));
    for i=1:size(config.hiddenLayers,2)
        filename=sprintf('%s%d, ',filename,config.hiddenLayers(i));
    end
    filename = sprintf('%s,%s',filename,tFcns);
    filename = sprintf('%s %s',filename,config.trainFcn);
    filename = sprintf('%s, %f',filename,config.trainRatio);
    filename = sprintf('%s, %f',filename,config.valRatio);
    filename = sprintf('%s, %f',filename,config.testRatio);
    filename = sprintf('%s, %d',filename,config.epochs);
    filename = sprintf('%s, %f',filename,config.learningRate);
end