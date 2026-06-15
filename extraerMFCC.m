function img = extraerMFCC(audio, fs)

    % 1. Asegurar columna y normalizar
    audio = audio(:);
    audio = audio / (max(abs(audio)) + 1e-8);

    % 2. Recortar silencios
    energia = audio .^ 2;
    umbral = 0.01 * max(energia);
    idx = find(energia > umbral);
    if length(idx) > 50
        audio = audio(idx(1):idx(end));
    end

    % 3. Padding a longitud fija (1 segundo)
    targetLen = fs;
    if length(audio) < targetLen
        audio = [audio; zeros(targetLen - length(audio), 1)];
    else
        audio = audio(1:targetLen);
    end

    % 4. Espectrograma Mel  ← 'Window' con vector hann, no 'WindowLength'
    windowLength  = round(0.025 * fs);   % 400 muestras
    overlapLength = round(0.015 * fs);   % 240 muestras

    [S, ~, ~] = melSpectrogram(audio, fs, ...
        'NumBands',      64, ...
        'FrequencyRange', [50, 8000], ...
        'Window',        hann(windowLength, 'periodic'), ...  % ← vector
        'OverlapLength', overlapLength);

    % 5. Escala logarítmica
    S = log10(S + 1e-6);

    % 6. Redimensionar y normalizar
    img = imresize(S, [64 64]);
    img = rescale(img);

end