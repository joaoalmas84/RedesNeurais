addpath("utils");

[dataset,targets]=getDataset('Test');

nets = getNet();

% array para armazenar as precisões
precisoes = zeros(1, length(nets));

results = cell(1, length(nets));

for i=1:length(nets)
    fprintf("\n[C] A testar a rede{%s} no dataset Test", nets{i}.filename);
    results{i} = testnet(nets{i}.savenet);
    fprintf("\n[C] Results: %f\n", results{i});
end

nets_names = cell(1, length(nets));

for i=1:length(nets)
    nets_names{i} = nets{i}.filename;
end

combined_data = [nets_names', results'];

xlswrite('infoTest.xlsx', combined_data);

% data=table({net.filename}, {results}, 'VariableNames',{'nome da rede'}, 'valores', {'skirt'});
%     writetable(data,'infoTest.xlsx','WriteMode','append');