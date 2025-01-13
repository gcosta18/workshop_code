% small script for opening dataset headbrain.csv for workshop STA module
% 04.01.2024 GC

clc
clear

datafolder = 'C:\Users\GCOSTA\Desktop\gitcode\workshop_data\';
% import data from csv file
T = readtable([datafolder 'headbrain.csv']);

disp(T.Properties.VariableNames);

%%
dgender = T.Gender;
dheadsize = T.HeadSize_cm_3_;
dbrainw = T.BrainWeight_grams_;

%% 
ndatap = 50;

dataidx = unique(round(linspace(1, length(dbrainw),ndatap)));
x = dheadsize(dataidx);
y = dbrainw(dataidx);

figure; scatter(x, y,"filled"); hold on
% axis([1000 2500; 1600 5000])


%% 
% Example Data
x = dheadsize(dataidx);
y = dbrainw(dataidx);

% Linear Regression using polyfit
p = polyfit(x, y, 1); % Fit degree-1 polynomial
slope = p(1);
intercept = p(2);

% Predicted y-values
y_pred = polyval(p, x);
% y_predexpand = polyval(p, 1:10000);

% Calculate R^2
SS_res = sum((y - y_pred).^2); % Residual sum of squares
SS_tot = sum((y - mean(y)).^2); % Total sum of squares
R2 = 1 - (SS_res / SS_tot);

% Display results
disp(['Slope: ', num2str(slope)]);
disp(['Intercept: ', num2str(intercept)]);
disp(['R^2: ', num2str(R2)]);

% Plot the results
figure;
scatter(x, y, 60 ,'filled','b'); % Scatter plot of original data
hold on;
plot(x, y_pred, 'r-', 'LineWidth', 2); % Plot the regression line
% plot(1:10000, y_predetended, 'g-', 'LineWidth', 2); % Plot the regression line

xlabel('head volume (cm3)', 'FontSize', 10);
ylabel('brain weight (g)');
title('Head volume vs Brain mass')
legend('Data', 'Linear Fit');
grid on;
ax = gca; % Get the current axes
ax.FontSize = 20;