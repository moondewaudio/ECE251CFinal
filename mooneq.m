function [output] = mooneq(freqs, gain, input, fs, bw)
%MOONQ [output, B, A] = moonq(frequency band centers, gain per band, input signal, fs, bandwidth)
%   Filters input based on specified frequencies and gains
numh = length(freqs);
bws = ones(size(freqs)) * bw;
output = zeros(size(input));
for i = 1:numh
    [B(:,i), A(:,i)] = moonbwbp(freqs(i), bws(i), fs, gain);
    temp = filter(B(:,i), A(:,i), input);
    output = output + temp./numh;
end
output = output ./ max(output);