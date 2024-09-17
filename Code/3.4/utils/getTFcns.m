function [tFcns]=getTFcns(config)
    tFcns='';
    for i=1:size(config.hiddenLayers,2)+1
        tFcn=cell2mat(config.transferFcn(i));
        tFcns=sprintf('%s %s,',tFcns,tFcn);
    end
end