% Parameters
num_neurons = 50;       % Number of neurons
duration = 1;           % Simulation duration in seconds
rate = 10;              % Mean firing rate (Hz)
dt = 0.001;             % Time step (1 ms)

% Time vector
time = 0:dt:duration;   % Time in seconds
num_time_steps = length(time);

% Generate Poisson spike trains
spike_trains = rand(num_neurons, num_time_steps) < rate * dt;

% Raster plot
figure;
subplot(2, 1, 1); % Top plot for raster
hold on;
for neuron = 1:num_neurons
    spike_times = find(spike_trains(neuron, :)) * dt;
    for spike = 1:length(spike_times)
        plot([spike_times(spike) spike_times(spike)], ...
             [neuron - 0.4 neuron + 0.4], 'k', 'LineWidth', 1);
    end
end
title('Raster Plot of Poisson Spike Trains');
xlabel('Time (s)');
ylabel('Neuron Index');
ylim([0, num_neurons + 1]);
hold off;

% Flatten all spike times for ISI calculation
all_spike_times = [];
for neuron = 1:num_neurons
    spike_times = find(spike_trains(neuron, :)) * dt;
    all_spike_times = [all_spike_times, spike_times];
end
all_spike_times = sort(all_spike_times);

% Calculate Inter-Spike Intervals (ISIs)
isis = diff(all_spike_times);

% Histogram of ISIs
subplot(2, 1, 2); % Bottom plot for histogram
histogram(isis, 'Normalization', 'probability', 'BinWidth', 0.001);
title('Histogram of Inter-Spike Intervals (ISIs)');
xlabel('ISI (s)');
ylabel('Probability');


%% With refractory periods


% Parameters
num_neurons = 50;       % Number of neurons
duration = 1;           % Simulation duration in seconds
rate = 5;              % Mean firing rate (Hz)
dt = 0.001;             % Time step (1 ms)
refractory_period = 0.005; % Refractory period in seconds (e.g., 5 ms)

% Time vector
time = 0:dt:duration;   % Time in seconds
num_time_steps = length(time);

% Generate Poisson spike trains with refractory period
spike_trains = false(num_neurons, num_time_steps);

for neuron = 1:num_neurons
    last_spike_time = -Inf; % Initialize the last spike time
    for t = 1:num_time_steps
        if (rand < rate * dt) && ((t * dt) - last_spike_time >= refractory_period)
            spike_trains(neuron, t) = true; % Generate spike
            last_spike_time = t * dt;      % Update last spike time
        end
    end
end

% Raster plot
figure;
subplot(2, 1, 1); % Top plot for raster
hold on;
for neuron = 1:num_neurons
    spike_times = find(spike_trains(neuron, :)) * dt;
    for spike = 1:length(spike_times)
        plot([spike_times(spike) spike_times(spike)], ...
             [neuron - 0.4 neuron + 0.4], 'k', 'LineWidth', 1);
    end
end
title('Raster Plot of Poisson Spike Trains with Refractory Period');
xlabel('Time (s)');
ylabel('Neuron Index');
ylim([0, num_neurons + 1]);
hold off;

%

% Flatten all spike times for ISI calculation
all_spike_times = [];
for neuron = 1:num_neurons
    spike_times = find(spike_trains(neuron, :)) * dt;
    all_spike_times = [all_spike_times, spike_times];
end
all_spike_times = sort(all_spike_times);

% Calculate Inter-Spike Intervals (ISIs)
isisB = diff(all_spike_times);

% Histogram of ISIs
subplot(2, 1, 2); % Bottom plot for histogram
histogram(isis, 'Normalization', 'probability', 'BinWidth', 0.001);
histogram(isisB, 'Normalization', 'probability', 'BinWidth', 0.001);
title('Histogram of Inter-Spike Intervals (ISIs)');
xlabel('ISI (s)');
ylabel('Probability');

%%
% Example ISI data
isisA = rand(1, 1000) * 0.05; % Example ISIs for condition A
isisB = rand(1, 1000) * 0.1;  % Example ISIs for condition B

% Histogram settings
bin_width = 0.001; % Bin width for histograms
edges = 0:bin_width:max([isisA, isisB]); % Define common bin edges

% Create histograms
[countsA, edgesA] = histcounts(isisA, edges, 'Normalization', 'probability');
[countsB, edgesB] = histcounts(isisB, edges, 'Normalization', 'probability');

% Plot the histograms
figure;
hold on;
bar(edgesA(1:end-1), countsA, 'BarWidth', 1, 'FaceColor', 'blue', 'EdgeColor', 'none', 'FaceAlpha', 0.5);
bar(edgesB(1:end-1), countsB, 'BarWidth', 1, 'FaceColor', 'red', 'EdgeColor', 'none', 'FaceAlpha', 0.5);

% Add labels and legend
xlabel('ISI (s)');
ylabel('Probability');
title('Comparison of Inter-Spike Intervals (ISIs)');
legend('Condition A (Low Rate)', 'Condition B (High Rate)');
grid on;
hold off;

%%
% Parameters
num_neurons = 20;       % Number of neurons
num_trials = 100;        % Number of trials
duration = 1;           % Trial duration in seconds
dt = 0.001;             % Time step (1 ms)
base_rate = 5;          % Baseline firing rate (Hz)
stimulus_rate = 30;     % Firing rate during stimulus (Hz)
stimulus_onset = 0.5;   % Stimulus onset time (s)
stimulus_duration = 0.2; % Stimulus duration (s)

% Time vector
time = 0:dt:duration;   
num_time_steps = length(time);

% Adjust Font Size
font_size = 14; % Desired font size for labels and ticks

% Generate spike trains for "no stimulus" condition
spike_trains_no_stim = false(num_trials, num_time_steps);
for trial = 1:num_trials
    spike_trains_no_stim(trial, :) = rand(1, num_time_steps) < base_rate * dt;
end

% Generate spike trains for "with stimulus" condition
spike_trains_with_stim = false(num_trials, num_time_steps);
for trial = 1:num_trials
    for t = 1:num_time_steps
        if time(t) >= stimulus_onset && time(t) < stimulus_onset + stimulus_duration
            spike_trains_with_stim(trial, t) = rand < stimulus_rate * dt; % Higher rate during stimulus
        else
            spike_trains_with_stim(trial, t) = rand < base_rate * dt;    % Baseline rate
        end
    end
end

% Calculate total spikes per trial
total_spikes_no_stim = sum(spike_trains_no_stim, 2); % Sum spikes for each trial
total_spikes_with_stim = sum(spike_trains_with_stim, 2);

% Plot raster for "no stimulus"
figure;
subplot(2, 2, 1);
hold on;
for trial = 1:num_trials
    spike_times = find(spike_trains_no_stim(trial, :)) * dt;
    for spike = 1:length(spike_times)
        plot([spike_times(spike) spike_times(spike)], ...
             [trial - 0.4 trial + 0.4], 'k', 'LineWidth', 3);
    end
end
title('Raster Plot (Baseline)');
xlabel('Time (s)', 'FontSize', font_size);
ylabel('Trial', 'FontSize', font_size);
set(gca, 'FontSize', font_size); % Adjust tick size
xlim([0, duration]);
ylim([0, num_trials + 1]);
hold off;

% Plot raster for "with stimulus"
subplot(2, 2, 2);
hold on;
for trial = 1:num_trials
    spike_times = find(spike_trains_with_stim(trial, :)) * dt;
    for spike = 1:length(spike_times)
        plot([spike_times(spike) spike_times(spike)], ...
             [trial - 0.4 trial + 0.4], 'r', 'LineWidth', 3);
    end
end
title('Raster Plot (Stimulus)');
xlabel('Time (s)', 'FontSize', font_size);
ylabel('Trial', 'FontSize', font_size);
set(gca, 'FontSize', font_size); % Adjust tick size
xlim([0, duration]);
ylim([0, num_trials + 1]);
hold off;

% Plot histogram of total spikes per trial (no stimulus)
subplot(2, 2, 3);
histogram(total_spikes_no_stim, 'BinWidth', 1, 'FaceColor', 'k');
title('Histogram of Total Spikes (Baseline)');
xlabel('Total Spikes per Trial', 'FontSize', font_size);
ylabel('N Trials', 'FontSize', font_size);
set(gca, 'FontSize', font_size); % Adjust tick size
ylim([0 20])
xlim([0 20])
grid on;

% Plot histogram of total spikes per trial (with stimulus)
subplot(2, 2, 4);
histogram(total_spikes_with_stim, 'BinWidth', 1, 'FaceColor', 'r');
title('Histogram of Total Spikes (Stimulus)');
xlabel('Total Spikes per Trial', 'FontSize', font_size);
ylabel('N Trials', 'FontSize', font_size);
set(gca, 'FontSize', font_size); % Adjust tick size
ylim([0 20])
xlim([0 20])
grid on;



