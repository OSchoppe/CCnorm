function [pMSE, MSE] = calc_pMSE(R,yhat)
%function [pMSE, MSE] = calc_pMSE(R,yhat)
%
% This function returns the peak mean square error (pMSE) between the
% predicted firing rate yhat and the neural data provided in R. The pMSE is
% defined as the MSE calculated for those time bins, in which the recorded
% firing rate y (mean of R over trials) is at least two standard deviations
% above its mean over time.
%
% Inputs:
%
% R		should be a NxT matrix (N: number of trials, T: number of time
%		bins) in which each row is the spike train of a given trial. Each
%		element R(n,t) thus contains the number of spikes that were
%		recorded during time bin t in trial n.
%
% yhat	should be a vector with T elements. It contains the predicted
%		firing rate over time.
%
%
% Written by Oliver Schoppe, 2015. (oliver.schoppe@tum.de)

% Check inputs
[N, T] = size(R);  
if(T<N), error('Please provide R as a NxT matrix.'); end
if(numel(yhat) ~= T), error('The prediction yhat should have as many time bins as R.'); end
yhat = yhat(:);
y = mean(R,1)';

% Calculate values
THR  = mean(y)+2*std(y);
MSE	 = mean((y-yhat).^2);
pMSE = mean((y(y>THR)-yhat(y>THR)).^2);

end
