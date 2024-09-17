function [net,accuracy,erro,segundos,testAccuracy,testErro] = treina(dataset,targets,config)

net = feedforwardnet(config.hiddenLayers);
for i=1:size(net.layers,1)
    tFcn=cell2mat(config.transferFcn(i));
    net.layers{i}.transferFcn=tFcn;
end
net.trainFcn=config.trainFcn;

net.trainParam.epochs=config.epochs;

net.divideParam.trainRatio=config.trainRatio;
net.divideParam.valRatio=config.valRatio;
net.divideParam.testRatio=config.testRatio;

net.trainParam.showWindow = false;

tic; %comeca a contar os segundos

[net,tr] = train(net, dataset, targets);


out = sim(net, dataset);

%plotconfusion(targets, out)

%plotperf(tr)
erro = perform(net, out,targets);

r=0;
for i=1:size(out,2)
    [a b] = max(out(:,i));
    [c d] = max(targets(:,i));
    if b == d
        r = r+1;
    end
end
accuracy = r/size(out,2)*100;
segundos=toc;

testErro=-1;
testAccuracy=-1;

if net.divideParam.testRatio~=0
    TInput = dataset(:, tr.testInd);
    TTargets = targets(:, tr.testInd);

    out = sim(net, TInput);
    plotconfusion(TTargets, out)


    testErro = perform(net, out,TTargets);
    r=0;
    for i=1:size(tr.testInd,2)               % Para cada classificacao
        [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
        [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
        if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
            r = r+1;
        end
    end
    testAccuracy = r/size(tr.testInd,2)*100;
end
 end