ads = audioDatastore( ...
    "dataset", ...
    IncludeSubfolders=true, ...
    LabelSource="foldernames");

numArchivos = numel(ads.Files);

X = zeros(64,64,1,numArchivos);

Y = ads.Labels;

reset(ads)

for k=1:numArchivos

    [audio,fs] = audioread(ads.Files{k});

    X(:,:,1,k) = extraerMFCC(audio,fs);

end