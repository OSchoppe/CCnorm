function SPE = calc_SPE(R,yhat)
%function SPE = calc_SPE(R,yhat)
%
% Following the methods of Sahani and Linden [1], this function calculates
% the signal power explained (SPE).
%
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
% Written by Oliver Schoppe, 2015. (based on [1])
%
% References:
% [1]:	Sahani, M. & Linden, J. F. "How linear are auditory cortical 
%		responses?" In Becker, S., Thrun, S. & Obermayer, K. (eds.) 
%		Advances in Neural Information Processing Systems 15, vol. 15, 
%		109â€“116 (MIT Press, 2003). 

% Check inputs
[N, T] = size(R);  
if(T<N), error('Please provide R as a NxT matrix.'); end
if(numel(yhat) ~= T), error('The prediction yhat should have as many time bins as R.'); end
yhat = yhat(:);
y = mean(R,1)';

% Calculate values
TP  = mean(var(R,[],2));			% total power
SP  = 1/(N-1)*(N*var(mean(R))-TP);	% signal power
SPE = (var(y)-var(y-yhat))/SP;		% signal power explained

end
