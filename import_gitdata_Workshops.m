%% 
% for MATLAB ONLINE

% load data from github
url = 'https://raw.githubusercontent.com/gcosta18/workshop_data/refs/heads/main/headbrain.csv';
filename = 'headbrain.csv';

websave(filename, url);

% Read the data into MATLAB
data = readtable(filename);

% Display the first few rows
head(data)

% load tutorial file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/W1T1.mlx';
filename = 'W1T1.mlx';
websave(filename, url);

% load tutorial file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/W1T2.mlx';
filename = 'W1T2.mlx';
websave(filename, url);

% load tutorial file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/W1T3.mlx';
filename = 'W1T3.mlx';
websave(filename, url);

% load warm up file from github
url = 'https://github.com/gcosta18/workshop_code/raw/refs/heads/main/warm_up.mlx';
filename = 'warm_up.mlx';
websave(filename, url);

