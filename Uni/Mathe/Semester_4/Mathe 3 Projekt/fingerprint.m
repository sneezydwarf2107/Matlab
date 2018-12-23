function peaks = fingerprint(sound, fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes a sound and sampling frequency.  It returns a binary
% matrix indicating the locations of peaks in the spectrogram.
%
% This function is currently complete.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define Variables

%sound = '1-01_AW.mp3';

new_smpl_rate = 8000; % sampling rate

time_res = .064; % for spectrogram

gs = 6; % grid size for spectrogram peak search

desiredPPS = 50; % scales the threshold

window = round(.064*new_smpl_rate); %define spectrogram window size

noverlap = round(.032*new_smpl_rate); %define window overlap

%% Toggle Plots

optional_plot_1 = true; %toggle magnitude & log magnitude plot

optional_plot_2 = true; %toggle magnitude & local peak plot

optional_plot_3 = true; %toggles precodet plots 



%% Preprocesing 

%[y,old_smpl_rate] = audioread(sound);
y = sound;
old_smpl_rate = fs;
y = resample(y,new_smpl_rate,old_smpl_rate);
y = mean(y,2);


%% Spectrogram + Magnitude Plot

[S,F,T] = spectrogram(y, window, noverlap, [], new_smpl_rate);
magS = abs(S);

if optional_plot_1
    
    figure(1);
    subplot(2,1,1);
    imagesc(T,F,magS);
    c = colorbar;
    c.Label.String = 'Magnitude';
    title('Spectrogram');
    xlabel('time (s)');
    ylabel('frequency (Hz)');
    axis xy;
    axis([min(T),max(T), min(F), max(F)]);

    subplot(2,1,2);
    logS = log(magS);
    imagesc(T,F,logS);
    c = colorbar;
    c.Label.String = 'log Magnitude (dB/Hz)';
    title('Log Spectrogram');
    xlabel('time (s)');
    ylabel('frequency (Hz)');
    axis xy;
    axis([min(T),max(T), min(F), max(F)]);
    hold
end

%% Find local Peaks

peaks = ones(size(magS)); % 2D boolean array indicating position of local peaks
for horShift = -gs:gs
    for vertShift = -gs:gs
        if(vertShift ~= 0 || horShift ~= 0) % Avoid comparing to self
            CS = circshift(magS, [vertShift,horShift]);
            p_peaks = (magS > CS);
            peaks = (peaks & p_peaks);    
        end
    end
end

if optional_plot_2
    figure(2);
    imagesc(peaks);
    colormap(1-gray);
end

%% Threshold

% EXPERIMENT WITH DIFFERENT THRESHOLD VALUES HERE.
threshold = 100000;

% Calculate threshold to use.
% We will set one threshold for the entire segment.  Improvements might be
% possible by adapting the threshold throughout the length of the segment,
% and setting a lower threshold for higher frequencies.

peakMags = peaks.*magS;
sortedpeakMags = sort(peakMags(:),'descend'); % sort all peak values in order
threshold = sortedpeakMags(ceil(max(T)*desiredPPS));

% Apply threshold
if (threshold > 0)
    peaks = (peakMags >= threshold);
end

if optional_plot_3
    % plot spectrogram
    figure(3)
    Tplot = [5, 10]; % Time axis for plot

%     logS = log(magS);
%     imagesc(T,F,logS);
%     title('Log Spectrogram');
%     xlabel('time (s)');
%     ylabel('frequency (Hz)');
%     axis xy
%     %axis([Tplot, -inf, inf])
%     axis([min(T),max(T), -inf, inf])
%     frame1 = getframe;

    % plot local peaks over spectrogram
    peaksSpec = (logS - min(min(logS))).*(1-peaks);
    imagesc(T,F,peaksSpec);
    title('Log Spectrogram');
    xlabel('time (s)');
    ylabel('frequency (Hz)');
    axis xy
    %axis([Tplot, -inf, inf])
    axis([min(T),max(T), -inf, inf])
%     frame2 = getframe;

%     movie([frame1,frame2],10,1)
end

end

