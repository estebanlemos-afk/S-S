% confusion.m  ← crea este archivo aparte
load redCalculadora.mat   % carga net, XVal, YVal

YPred = classify(net, XVal);
confusionchart(YVal, YPred)