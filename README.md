# CCnorm
Matlab code for performance measures for computational neural models

This repository contains Matlab code to calculate various performance measures for computational neural models. Use them to evaluate the performance of a model to predict neuronal responses to a stimulus. The performance measures provided here allow you to compare the prediction ("yhat") to the neural response ("R"). Here, three Matlab functions are provided to calculate the model performance as the absolute correlation coefficient (CCabs), the normalized correlation coefficient (CCnorm), which controls for neural variability, the mean square errror (MSE), the peak MSE (pMSE), and signal power explained (SPE). We recommend using CCnorm as the standard measure of model performance.


--> R should be a NxT matrix (N: number of trials, T: number of time bins) in which each row is the spike train of a given trial. Each element R(n,t) thus contains the number of spikes that were recorded during time bin t in trial n.


--> yhat should be a vector with T elements. It contains the predicted firing rate over time.


There are four Matlab functions provided:

[CCnorm, CCabs, CCmax] = calc_CCnorm(R,yhat);

[CC_norm, CC_abs, CC_max] = calc_CCnorm_jackknife(R,yhat)

[pMSE, MSE] = calc_pMSE(R,yhat);

SPE = calc_SPE(R,yhat);
