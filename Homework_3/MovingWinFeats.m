function feature_vals = MovingWinFeats(x, fs, winLen, winDisp, featFn)

% MovingWinFeats Computes featFn in all windows of a signal
%   x: signal
%   fs: sampling rate of signal
%   winLen: length of windows in seconds
%   winDisp: size of stride for sliding windows in seconds
%   featFn: feature function

num_wins = ((length(x) - (winLen * fs))/(winDisp * fs) + 1);
feature_vals = zeros(1, round(num_wins));

win_start_idx = 1;
for i = 1:num_wins
    win_end_idx = win_start_idx + (winLen * fs) - 1;
    curr_win_x = x(win_start_idx:win_end_idx);
    feature_vals(i) = featFn(curr_win_x);
    win_start_idx = win_start_idx + (winDisp * fs);
end

end

