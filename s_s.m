clear all; close all; clc; clearvars;

% =========================================================================
% 1. CONFIGURACIÓN DE AUDIO (Optimizada para Inteligencia Artificial)
% =========================================================================
fs = 16000;      % CAMBIO CLAVE: Frecuencia estándar para modelos de Deep Learning
duration = 5; 

N   = 4;         
Fc1 = 200;       % Corta ruidos graves de fondo (motores, soplidos)
Fc2 = 5000;      % Deja un margen saludable antes de los 8000 Hz de Nyquist

% Construcción del filtro Butterworth pasa-banda
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, fs);
Hd = design(h, 'butter');

% =========================================================================
% 2. GRABACIÓN DE VOZ
% =========================================================================
disp("Hable claro y fuerte ahora...");
grabacion = audiorecorder(fs, 24, 1);
recordblocking(grabacion, duration);
disp("Grabación finalizada, procesando audio...");

audio_vect = getaudiodata(grabacion);

% Normalización limpia para evitar saturación (Clipping)
ampl_data = 0.8 * audio_vect / max(abs(audio_vect));

% --- Aplicar filtro pasabanda diseñado ---
audioFiltrado = filter(Hd, ampl_data);      

% =========================================================================
% 3. REPRODUCCIÓN DE CONTROL (Para que escuches la diferencia)
% =========================================================================
disp("Escuchando señal original...");
orign = audioplayer(audio_vect, fs);    
playblocking(orign);

disp("Escuchando señal filtrada...");
rep = audioplayer(audioFiltrado, fs);    
playblocking(rep);

% =========================================================================
% 4. RECONOCIMIENTO DE VOZ EN ESPAÑOL (Deep Learning)
% =========================================================================
clc;
emformerSpeechClient = speechClient("Google");
transcript = speech2text(audioFiltrado, fs, Client=emformerSpeechClient);

%  transcript = speech2text(audioFiltrado, fs, language="spanish");
% clc;
% disp("=================================");
% disp("TEXTO RECONOCIDO:");
% disp(transcript);
% disp("=================================");