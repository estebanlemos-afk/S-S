% load redCalculadora.mat
% 
% fs = 16000;
% recObj = audiorecorder(fs,16,1);
% disp("Hable")
% recordblocking(recObj,1.5)
% audio = getaudiodata(recObj);
% img = extraerMFCC(audio,fs);
% img = reshape(img,[64 64 1]);
% resultado = classify(net,img);
% disp(resultado)

% calculadora_serial.m
clear; clc;
load redCalculadora.mat

fs = 16000;
duracion = 1.5;

% Configurar puerto serial  ← cambia 'COM3' por tu puerto
% s = serialport("COM3", 9600);
% fprintf('=== CALCULADORA DE VOZ → SERIAL ===\n');
fprintf('Orden: numero → operacion → numero → igual\n\n');

% Mapeo de palabras a lo que se envía por serial
mapeo = containers.Map(...
    {'cero','uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','suma','resta','multiplica','divide','igual'}, ...
    {'0','1','2','3','4','5','6','7','8','9','+','-','*','/','='});

% while true
    
    % Captura secuencia: num op num igual
    secuencia = {'operacion','primer numero','segundo numero'};

    expresion = '';  % texto que se va construyendo

    for i = 1:length(secuencia)

        fprintf('Di el/la %s...\n', secuencia{i});

        recObj = audiorecorder(fs, 16, 1);
        recordblocking(recObj, duracion);
        audio = getaudiodata(recObj);

        img = extraerMFCC(audio, fs);
        img = reshape(img, [64 64 1]);
        palabra = classify(net, img);
        palabra = char(palabra);

        fprintf('Entendi: %s\n', palabra);
        pause(2);
        if isKey(mapeo, palabra)
            % Agregar coma entre elementos
            if isempty(expresion)
                expresion = mapeo(palabra);
            else
                expresion = [expresion, ',', mapeo(palabra)];
            end
        else
            fprintf('No reconoci "%s", reiniciando...\n\n', palabra);
            expresion = '';
            break
        end

    end
     fprintf('%s\n\n', expresion);

    % % Solo enviar si la secuencia está completa (4 palabras)
    % if length(expresion) == 4  % ej: "3+2="
    %     fprintf('\n  Enviando por serial: %s\n\n', expresion);
    %     write(s, expresion, "char");
    % end

%end