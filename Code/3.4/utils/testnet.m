function [accTestTD]=testnet(net)

[dataset,targets]=getDataset('Test');

out=sim(net,dataset);

plotconfusion(targets,out);

    r=0;
    for i=1:size(dataset,2)               % Para cada classificacao
        [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
        [c d] = max(targets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
        if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
            r = r+1;
        end
    end

    accTestTD = r/size(dataset,2)*100;
end