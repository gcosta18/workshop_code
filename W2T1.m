%% Spike Train Analysis Tutorial

% Tutorial using data from https://www.danielwagenaar.net/teach.html
% and codes from https://github.com/wagenadl/mbl-nsb-toolbox

clc
clear
close all

% % % % % % % % % % % % LOAD DATA % % % % % % % % % % % % % % % % 

% load electrical recordings
load('spike_train_data_w2t1.mat')

% load time stamps of each data
load('spike_train_time_w2t1.mat') % $$$

% -------------------------- inspect --------------------------- %
% - What is the size of the data?

% - what is the first and the last time point time point? % $$$
% firstime = 
% lasttime = 

% - What is the sampling rate of the signal? % $$$
% srate = n sample/time
srate = 10000;
% -------------------------------------------------------------- %

% - Plot one of the channel 8 % $$$
elec = 8;
figure;
plot(vlt(:,elec))

% - Plot aligned with the time stamps
figure;
plot(tms, vlt(:,elec)) % $$$

% - Plot only the first 10 secs of the data
figure;
plot(tms(1:100000), vlt(1:100000,elec)) % $$$

%% Find spikes on 8th channel

% OBS: the signal is already high-pass filtered, otherwise a hp-filt [300
% 3000 Hz] would be appropriate at this stage

elec = 8;
cdata = vlt(:,elec); % $$$

% select a reasonable threshold 
threshold = 0.6; % $$$


% get indices of values above threshold
idx_above = cdata > threshold;
spike_indices = find(idx_above);

% Extract spike times (in seconds)
spike_times = tms(spike_indices);

% Plot the data + spike_times
figure; plot(tms, cdata); hold on

% ___________________________________________________________________ %
% test
time_p = 100;
plot(time_p, 0, 'gx', 'LineWidth', 40)
plot(tms(spike_indices), cdata(spike_indices), 'rx')
% ___________________________________________________________________ %

% - Does the plot look representative of the spikes peaks?
% - What is wrong with it?



%% Step 3: Detect spikes using findpeaks

zthreshold = 5;

min_peak_height = zthreshold * std(cdata); % Minimum peak height
min_peak_distance = 0.001 * srate; % Minimum distance between peaks in samples

% Use MATLAB's findpeaks function to detect spikes
[peak_values, peak_indices] = findpeaks(cdata, 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);

%% 
% Plot the data + spike_times
figure; plot(tms, cdata); hold on
plot(tms(peak_indices), cdata(peak_indices), 'g.', 'MarkerSize',10)

% - Is the threshold good enough? What if you wanted to be more selective?

%% use another threshold, keep the previous peaks
zthreshold = 10;

min_peak_height = zthreshold * std(cdata); % Minimum peak height
min_peak_distance = 0.01 * srate; % Minimum distance between peaks in samples

% Use MATLAB's findpeaks function to detect spikes
[peak_values_b, peak_indices_b] = findpeaks(cdata, 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_distance);

figure; plot(tms, cdata); hold on
plot(tms(peak_indices), cdata(peak_indices), 'g.', 'MarkerSize', 10);
plot(tms(peak_indices_b), cdata(peak_indices_b), 'r.', 'MarkerSize', 10)

%% Step 4: Calculate firing rate
% Compute firing rate over time
bin_size = 0.1; % Bin size in seconds
edges = 0:bin_size:max(tms);
hist_counts = histcounts(spike_times, edges);
firing_rate = hist_counts / bin_size;

%% Step 5: Compute interspike intervals (ISIs)
% Calculate time differences between successive spikes
isi = diff(spike_times); % ISI in seconds

%% Step 6: Plot the results
% Plot the raw signal and detected spikes
figure;
subplot(3, 1, 1);
plot(tms, cdata);
hold on;
plot(spike_times, threshold * ones(size(spike_times)), 'ro');
hold off;
title('Raw Signal with Detected Spikes');
xlabel('Time (s)'); ylabel('Amplitude');

% Plot the firing rate
subplot(3, 1, 2);
plot(edges(1:end-1) + bin_size/2, firing_rate);
title('Firing Rate');
xlabel('Time (s)'); ylabel('Firing Rate (Hz)');

% Plot ISI distribution
subplot(3, 1, 3);
histogram(isi, 50);
title('Interspike Interval Distribution');
xlabel('ISI (s)'); ylabel('Count');

%% Step 7: Save results
% Save spike times and ISI data
save('spike_analysis_results.mat', 'spike_times', 'isi', 'firing_rate');
