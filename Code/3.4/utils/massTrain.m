function massTrain(N,config)

    [dataset,targets]=getDataset(config.nomeDataset);
    
    nets = cell(N,1);
    accs = zeros(1,N);
    erros = zeros(1,N);
    tempo = zeros(1,N);
    testAccs = zeros(1,N);
    testErros = zeros(1,N);
    bestTrainAcc=0;
    bestTestAcc=0;
    
    for i=1:N
        [n,acc,erro,segundos,testAcc,testErro]=treina(dataset,targets,config);
        nets{i}=n;
        accs(i)=acc;
        erros(i)=erro;
        tempo(i)=segundos;

        if testAcc~=-1 && testErro~=-1
            testAccs(i)=testAcc;
            testErros(i)=testErro;
        end

    end
    
    mediaAcc=mean(acc)
    mediaErro=mean(erro)
    mediaSegundos=mean(tempo)

    if size(testAccs,2)~=0
        mediaTestAcc=mean(testAccs)
        mediaTestErro=mean(testErros)
    end
    
    saveindex=findBestNet(accs,testAccs);
    bestTrainAcc=accs(saveindex);
    bestTestAcc=testAccs(saveindex);
    savenet=nets{saveindex};
    pause(2);
    
    filename = getFileName(config);
    save(sprintf('%s.mat',filename),"savenet");
    
    tFcns=getTFcns(config);
    hiddenLayers='';

    for i=1:size(config.hiddenLayers,2)
        hiddenLayers=sprintf('%s %d',hiddenLayers,config.hiddenLayers(1,i));
    end
    
    data=table({config.nomeDataset},size(config.hiddenLayers,2),{hiddenLayers},{tFcns},{config.trainFcn},config.trainRatio,config.valRatio,config.testRatio,config.epochs,config.learningRate,mediaAcc,mediaErro,mediaSegundos,mediaTestAcc,mediaTestErro,bestTrainAcc,bestTestAcc,'VariableNames',{'nomeDataset','nCamadasEscondidas','camadas escondidas','funções de ativação','função de treino','trainRatio','valRatio','testRatio','epochs','lr','accTrain', 'erroTrain','segundos','accTest','erroTest','best acc train','best acc test'});
    writetable(data,'info.xlsx','WriteMode','append');
    accs(saveindex)=0;
    testAccs(saveindex)=0;
    nets{saveindex}=[];

end