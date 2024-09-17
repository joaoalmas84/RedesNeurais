addpath("utils");

filePath = sprintf('../datasets/transformed/Train_Treated.csv');
opts = detectImportOptions(filePath);
opts.Delimiter = ';';
opts.VariableTypes = ["double", "double", "double", "double", ...
            "double", "double", "double", ...
            "double", "double", "double", ...
            "double", "double", "double", ...
            "double", "double", "double", ...
            "double", "double"];
data = readtable(filePath, opts);

new_data = data;

for col = 1:size(data,2)-1
    column_data = data{:,col};
    new_data{:,col} = normalize(column_data);
end

new_data.Properties.VariableNames = ["ID", "N_Days", "Status", "Drug", "Age", "Sex", "Ascites", "Edema", "Bilirubin", "Cholesterol",...
"Albumin", "Copper", "Alk_Phos", "SGOT", "Tryglicerides", "Platelets", "Prothrombin", "Stage"];

writetable(new_data, '../datasets/transformed/Train_Normalized.csv', 'Delimiter', ';');