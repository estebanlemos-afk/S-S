clear;clc;

fs = 16000;
duracion = 1.5;

persona='lem';
palabras = {
    'cero','uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','suma','resta','multiplica','divide','igual'
};

numMuestras = 100;

for p = 1:length(palabras)

    carpeta = fullfile("dataset",palabras{p});

    if ~exist(carpeta,'dir')
        mkdir(carpeta)
    end

    fprintf('\nPALABRA: %s\n',palabras{p});

    for k = 1:numMuestras
        fprintf('Muestra %d/%d\n',k,numMuestras);
        recObj = audiorecorder(fs,16,1);
        recordblocking(recObj,duracion);
        audio = getaudiodata(recObj);
        nombre = sprintf('%s_%s_%03d.wav',palabras{p},persona,k);
        audiowrite(fullfile(carpeta,nombre),audio,fs);

    end
end


% persona = '____';  % nombre de la persona nueva
% palabras = {'cero','uno''dos','tres','cuatro','cinco','seis','siete','ocho','nueve','suma','resta','multiplica','divide','igual'};
% 
% for p = 1:length(palabras)
%     carpeta = fullfile('dataset', palabras{p}); %colocar el nombre de la nueva carpeta generada
%     archivos = dir(fullfile(carpeta, '*.wav'));
% 
%     for k = 1:length(archivos)
%         nombreViejo = fullfile(carpeta, archivos(k).name);
%         nombreNuevo = fullfile(carpeta, ...
%             sprintf('%s_%s_%03d.wav', palabras{p}, persona, k));
%         movefile(nombreViejo, nombreNuevo);
%     end
% end