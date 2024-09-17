opts = detectImportOptions('../datasets/default/Train.csv');
opts.Delimiter = ';';
opts.VariableTypes = ["double", "double", "categorical", "categorical", ...
                      "double", "categorical", "categorical", ...
                      "categorical", "double", "double", ...
                      "double", "double", "double", ...
                      "double", "double", "double", ...
                      "double", "double"];
data = readtable('../datasets/default/Train.csv', opts);

mapping = containers.Map({'C', 'CL', 'D', 'M', 'F', 'Placebo', 'D-penicillamine', 'N', 'Y','S'}, [0, 1, 2, 0, 1, 0, 1, 0, 1,2]);

warning('off','all');
for i = 1:height(data)
    for j = 1:width(data)
        if iscategorical(data{i,j})
            category = char(data{i, j});
            if isKey(mapping,category)
                new_data(i, j) = array2table(mapping(category));
            else
                new_data(i,j)=array2table(NaN);
            end
        else
            new_data(i,j) = data(i,j);
        end
    end
end
warning('on','all');

new_data.Properties.VariableNames = ["ID", "N_Days", "Status", "Drug", "Age", "Sex", "Ascites", "Edema", "Bilirubin", "Cholesterol",...
    "Albumin", "Copper", "Alk_Phos", "SGOT", "Tryglicerides", "Platelets", "Prothrombin", "Stage"];

writetable(new_data, '../datasets/transformed/Train_Treated.csv', 'Delimiter', ';');
