%% Week 2
% for MATLAB ONLINE

% load data from github
url = 'https://raw.githubusercontent.com/gcosta18/workshop_data/refs/heads/main/headbrain.csv';
filename = 'headbrain.csv';

websave(filename, url);

% Read the data into MATLAB
data = readtable(filename);

% Display the first few rows
head(data)

% load tutorial solutions file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/W1T3.mlx';
filename = 'W1T3.mlx';
websave(filename, url);


% load data from github
url = 'https://github.com/gcosta18/workshop_data/raw/refs/heads/main/spike_train_data_w2t1.mat';
filename = 'spike_train_data_w2t1.mat';
websave(filename, url);

% load data from github
url = 'https://github.com/gcosta18/workshop_data/raw/refs/heads/main/spike_train_time_w2t1.mat';
filename = 'spike_train_time_w2t1.mat';
websave(filename, url);


% load tutorial file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/W2T1.mlx';
filename = 'W2T1.mlx';
websave(filename, url);
