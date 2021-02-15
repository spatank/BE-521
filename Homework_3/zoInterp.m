function interp_output = zoInterp(x, numInterp)
% zoInterp Performs zeroth-order interpolation for a signal with sliding
% windows
%   Copy each value of x numInterp times

interp_output = reshape(repmat(x, numInterp, 1), 1, length(x) * numInterp);

end

