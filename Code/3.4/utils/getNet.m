function [nets] = getNet()

    folder = "skirt";
    
    % Ficheiros na pasta
    ficheiros = dir(fullfile(folder, '*.mat'));
    
    % Array para armazenar as redes neurais
    nets = cell(1, length(ficheiros));

    % Itera sobre todos os ficheiros na pasta
    for i = 1:length(ficheiros)
        % Carrega as variáveis do ficheiro .mat
        data = load(fullfile(folder, ficheiros(i).name));
        
        % Armazena todas as redes neurais do ficheiro numa célula
        nets{i}.savenet = data.savenet;
        nets{i}.filename = ficheiros(i).name;
    
    end
end