% Clear workspace and close all figures
clear; close all; clc;

% Load audio file
[audioIn, Fs] = audioread('input_audio.wav'); % Replace 'input_audio.wav' with your audio file
info = audioinfo('input_audio.wav');

% Display the audio information
disp(info);

% Play original audio
sound(audioIn, Fs);
pause(length(audioIn)/Fs + 2);

% Plot the original audio signal
figure;
subplot(3, 1, 1);
plot(audioIn);
title('Original Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% Design a low-pass filter
filterOrder = 8;
cutoffFreq = 0.2; % Normalized cutoff frequency (0 to 1, where 1 corresponds to half the sampling rate)
[b, a] = butter(filterOrder, cutoffFreq, 'low');

% Apply the low-pass filter
audioFiltered = filter(b, a, audioIn);

% Plot the filtered audio signal
subplot(3, 1, 2);
plot(audioFiltered);
title('Filtered Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% Add echo effect
delay = 0.25; % 250 ms delay
alpha = 0.6; % Echo attenuation factor
delaySamples = round(delay * Fs);

audioEcho = audioFiltered;
for i = (delaySamples + 1):length(audioFiltered)
    audioEcho(i) = audioFiltered(i) + alpha * audioFiltered(i - delaySamples);
end

% Plot the audio signal with echo
subplot(3, 1, 3);
plot(audioEcho);
title('Audio Signal with Echo');
xlabel('Sample Number');
ylabel('Amplitude');

% Play processed audio
sound(audioEcho, Fs);
pause(length(audioEcho)/Fs + 2);

% Save the processed audio to a new file
audiowrite('output_audio.wav', audioEcho, Fs); % Save the processed audio
