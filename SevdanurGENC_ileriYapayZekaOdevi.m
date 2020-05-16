SurekliEkranGoruntusuYakala = true;
set(gcf,'CloseRequestFcn','SurekliEkranGoruntusuYakala = false; closereq');

YatayDegeri = figure;
YatayDegeri.Position(3) = 2*YatayDegeri.Position(3);
birinciEkran = subplot(1,2,1);
ikinciEkran = subplot(1,2,2); 

KameraBaglantisiSagla = webcam; 
NeuralNetworkDataSetYukle = alexnet;   

while true
    YakalananGoruntu = snapshot(KameraBaglantisiSagla);
    image(birinciEkran,YakalananGoruntu);
    
    YakalananGoruntu = imresize(YakalananGoruntu,[227 227]);
    [EkranEtiketi,GoruntuDegeri] = classify(NeuralNetworkDataSetYukle,YakalananGoruntu);
    title(birinciEkran,{char(EkranEtiketi),num2str(max(GoruntuDegeri),2)});

    [~,KacAdetOlasilik] = sort(GoruntuDegeri,'descend');
    KacAdetOlasilik = KacAdetOlasilik(10:-1:1);
    SinifIsimleri = NeuralNetworkDataSetYukle.Layers(end).ClassNames;
    SecilenSinifIsmi = SinifIsimleri(KacAdetOlasilik);
    SecilenSinifaAitOlasilikDegeri = GoruntuDegeri(KacAdetOlasilik); 
      
    barh(ikinciEkran,SecilenSinifaAitOlasilikDegeri);
    title(ikinciEkran,'ilk 10 olasi sinifa ait isimler');
    xlabel(ikinciEkran,'siniflarin olasilik degerleri');
    xlim(ikinciEkran,[0 1]);
    
    yticklabels(ikinciEkran,SecilenSinifIsmi)
    ikinciEkran.YAxisLocation = 'right';

    drawnow
end