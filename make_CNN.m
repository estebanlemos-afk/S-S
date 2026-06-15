% make_CNN.m mejorado
numClasses = numel(categories(Y));

layers = [
    imageInputLayer([64 64 1])

    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,64,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    fullyConnectedLayer(128)
    reluLayer
    dropoutLayer(0.4)       % <-- CLAVE para evitar sobreajuste

    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
];