%% Final project part 1
% Prepared by John Bernabei and Brittany Scheid

% One of the oldest paradigms of BCI research is motor planning: predicting
% the movement of a limb using recordings from an ensemble of cells involved
% in motor control (usually in primary motor cortex, often called M1).

% This final project involves predicting finger flexion using intracranial EEG (ECoG) in three human
% subjects. The data and problem framing come from the 4th BCI Competition. For the details of the
% problem, experimental protocol, data, and evaluation, please see the original 4th BCI Competition
% documentation (included as separate document). The remainder of the current document discusses
% other aspects of the project relevant to BE521.


%% Start the necessary ieeg.org sessions (0 points)

clc; close all; clear;

cd('/Users/sppatankar/Developer/BE-521')
addpath(genpath('ieeg-matlab-1.14.49'))
addpath(genpath('Project/Part_1'));

username = 'spatank';
passPath = 'spa_ieeglogin.bin';

% Load training ecog from each of three patients
s1_train_ecog = IEEGSession('I521_Sub1_Training_ecog', username, passPath);
s2_train_ecog = IEEGSession('I521_Sub2_Training_ecog', username, passPath);
s3_train_ecog = IEEGSession('I521_Sub3_Training_ecog', username, passPath);

% Load training dataglove finger flexion values for each of three patients
s1_train_dg = IEEGSession('I521_Sub1_Training_dg', username, passPath);
s2_train_dg = IEEGSession('I521_Sub2_Training_dg', username, passPath);
s3_train_dg = IEEGSession('I521_Sub3_Training_dg', username, passPath);

clc; % remove the session loading warnings from IEEG
all_data = load('final_proj_part1_data.mat');

%% Extract dataglove and ECoG data 
% Dataglove should be (samples x 5) array 
% ECoG should be (samples x channels) array
subj = 1; % change this depending on which subject is being processed
ecog = all_data.train_ecog{subj};
dataglove = all_data.train_dg{subj};
% (1.1) There are 300000 samples in the raw recording.
% (1.2) The filter is a bandpass filter allowing signal in the range from
% 0.15 Hz to 200 Hz.

% Split data into a train and test set (use at least 50% for training)

[m, n] = size(ecog);
P = 0.5; % percentage of training data
idx = randperm(m);
train_ecog = ecog(idx(1:round(P * m)), :);
train_dg = dataglove(idx(1:round(P * m)), :);
val_ecog = ecog(idx(round(P * m) + 1:end), :);
val_dg = dataglove(idx(round(P * m) + 1:end), :);

%% Get Features
% run getWindowedFeats function

fs = s1_train_ecog.data.sampleRate;
window_length = 100/1000; % window size (s)
window_overlap = 50/1000; % window displacement (s)

% https://cs231n.github.io/convolutional-networks/
NumWins = @(xLen, fs, winLen, winDisp) ...
    ((xLen - (winLen * fs))/(winDisp * fs) + 1);
num_wins = ...
    NumWins(length(train_ecog(:, 1)), fs, window_length, window_overlap);

% create R matrix
R = getWindowedFeats(train_ecog, fs, window_length, window_overlap);

%% Train classifiers (8 points)

% Classifier 1: Get angle predictions using optimal linear decoding. That is, 
% calculate the linear filter (i.e. the weights matrix) as defined by 
% Equation 1 for all 5 finger angles.

% Downsampling using means over windows for the dataglove signal
num_dg_channels = size(train_dg, 2);
Y_train = zeros(num_wins, num_dg_channels);
win_start_idx = 1;
for i = 1:num_wins
    win_end_idx = win_start_idx + (window_length * fs) - 1;
    curr_window = train_dg(win_start_idx:win_end_idx, :);
    Y_train(i, :) = mean(curr_window);
    win_start_idx = win_start_idx + (window_overlap * fs);
end
f = mldivide(R' * R, R' * Y_train);
Y_hat_train = R * f;
train_corrs = diag(corr(Y_hat_train, Y_train));

% Try at least 1 other type of machine learning algorithm, you may choose
% to loop through the fingers and train a separate classifier for angles 
% corresponding to each finger

alt_models = cell(1, 5);
alt_models_train_performance = cell(1, 5);
for finger = 1:num_dg_channels
    Y_fing = Y_train(:, finger);
    alt_models{finger} = fitrensemble(R, Y_fing);
    Y_hat_train = predict(alt_models{finger}, R);
    alt_models_train_performance{finger} = diag(corr(Y_hat_train, Y_fing));
end

% Try a form of either feature or prediction post-processing to try and
% improve underlying data or predictions.


%% Correlate data to get test accuracy and make figures (2 point)

% Calculate accuracy by correlating predicted and actual angles for each
% finger separately. Hint: You will want to use zohinterp to ensure both 
% vectors are the same length.

R_val = getWindowedFeats(val_ecog, fs, window_length, window_overlap);

Y_val = zeros(num_wins, num_dg_channels);
win_start_idx = 1;
for i = 1:num_wins
    win_end_idx = win_start_idx + (window_length * fs) - 1;
    curr_window = val_dg(win_start_idx:win_end_idx, :);
    Y_val(i, :) = mean(curr_window);
    win_start_idx = win_start_idx + (window_overlap * fs);
end
    
f_val = mldivide(R_val' * R_val, R_val' * Y_val);
Y_hat_val = R_val * f_val;

val_corrs = diag(corr(Y_hat_val, Y_val));

alt_models_val_performance = cell(1, 5);
for finger = 1:num_dg_channels
    Y_fing = Y_val(:, finger);
    model = alt_models{finger};
    Y_hat_val = predict(model, R_val);
    alt_models_val_performance{finger} = diag(corr(Y_hat_val, Y_fing));
end
