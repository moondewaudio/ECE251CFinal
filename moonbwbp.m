function [B,A] = moonbwbp(fc, bw, fs, g)
%MOONBP [h, w] = moonbp(center frequency, desired bandwidths, sampling frequency, gain (dB))
%   This function implements a biquad bandpass filter with gain G and
%   returns the numerator coefficients B and denominator coeffecients A
T = 1/fs;
%bw = fc/q;
R = exp(-pi * bw * T);
gain = 10^(g/20);
B = gain*[1 0 -R];
A = [1 -2*R*cos(2*pi*fc*T) R*R];
end