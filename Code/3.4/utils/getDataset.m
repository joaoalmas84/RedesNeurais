function [dataset, target]= getDataset(nome)
    filePath = sprintf('../datasets/default/%s.csv',nome);
    opts = detectImportOptions(filePath);
    opts.Delimiter = ';';
    opts.VariableTypes = ["double", "double", "double", "double", ...
                "double", "double", "double", ...
                "double", "double", "double", ...
                "double", "double", "double", ...
                "double", "double", "double", ...
                "double", "double"];
    dataset = readtable(filePath, opts);

    dataset=sortrows(dataset,"Stage");

    target=getTarget(dataset(:,end));

    dataset= table2array(dataset);

    dataset(:,1)=[];
    dataset(:,end)=[];

    dataset=dataset';
end