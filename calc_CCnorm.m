function [CCnorm, CCabs, CCmax] = calc_CCnorm(R,yhat)
%function [CCnorm, CCabs, CCmax] = calc_CCnorm(R,yhat)
%
% This function returns the absolute correlation coefficient CCabs and the
% normalized correlation coefficient CCnorm. The normalization discounts
% the inherent inter-trial variability of the neural data provided in R.
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
%
% References:
% [1]:	Sahani, M. & Linden, J. F. "How linear are auditory cortical 
%		responses?" In Becker, S., Thrun, S. & Obermayer, K. (eds.) 
%		Advances in Neural Information Processing Systems 15, vol. 15, 
%		109–116 (MIT Press, 2003). 

% Check inputs
[N, T] = size(R);  
if(T<N), error('Please provide R as a NxT matrix.'); end
if(numel(yhat) ~= T), error('The prediction yhat should have as many time bins as R.'); end
yhat = yhat(:);
y = mean(R,1)';

% Precalculate basic values for efficiency
Ey		= mean(y);							 % E[y]
Eyhat	= mean(yhat);						 % E[yhat]
Vy		= sum((y-Ey).*(y-Ey))/T;			 % Var(y)
Vyhat	= sum((yhat-Eyhat).*(yhat-Eyhat))/T; % Var(yhat)
Cyyhat	= sum((y-Ey).*(yhat-Eyhat))/T;		 % Cov(y,yhat)

% Calculate signal power (see [1])
SP		= (var(sum(R,1))-sum(var(R,[],2)))/(N*(N-1));

% Calculate CC values
CCabs	= Cyyhat/sqrt(Vy*Vyhat);
CCnorm	= Cyyhat/sqrt(SP*Vyhat);
CCmax	= sqrt(SP/Vy);

if SP<=0
	fprintf('Signal power estimate is negative or zero, so CCmax and CCnorm\n');
	fprintf('cannot be calculated. This happens if the neural data is very\n');
	fprintf('noisy, i.e. not driven by the stimulus at all.\n');
	CCnorm = NaN;
	CCmax  = 0;
end


end
