% splitDataset.m  ← archivo separado
function [XTrain,YTrain,XVal,YVal] = splitDataset(X, Y, ratio)
    n = size(X, 4);
    idx = randperm(n);
    corte = round(ratio * n);
    XTrain = X(:,:,:,idx(1:corte));
    YTrain = Y(idx(1:corte));
    XVal   = X(:,:,:,idx(corte+1:end));
    YVal   = Y(idx(corte+1:end));
end