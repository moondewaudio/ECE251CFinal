function output = cwtTrackEQ(g2, fs, numHarmAdj, bw, gain, numVoices, winTime)
%cwtTrackEQ(input, fs, numHarmAdj, bandwidth, gain, numCWTVoices, winTime)
% input: mono signal to filter
% fs: sampling frequency of the input
% numHarmAdj: # of harmonics to adjust
% bandwidth: bandwidth of filters applied to harmonics
% gain: dB gain adjustment of harmonics
% numCWTVoices: how many voices per octave for the CWT transformation
% winTime: how often does the eq switch frequencies

numSamples = length(g2);

% cwt on the input
[cw, f] = cwt(g2, 'bump', fs, 'VoicesPerOctave', numVoices);

% batch processing for faster operation: condense into winTime long second
% chunks to process

winSize = round(fs * winTime, 0);

% zero pad data to fit even windows
numPad = mod(numSamples, winSize);
cw(:, numSamples+1 : numSamples + winSize - numPad) = 0;
g2(numSamples+1 : numSamples + winSize - numPad) = 0;

output = zeros(size(g2));
[~, newSamps] = size(cw);
numWin = newSamps / winSize;

% filtering
for i = 1:numWin
    % find maximum harmonics in window
    [~, maxFreqsInd] = maxk(cw(:, (i-1)*winSize+1 : i*winSize), numHarmAdj, 'ComparisonMethod', 'abs');

    % average harmonics to decide on center frequencies for the filter
    fcents = round(mean(f(maxFreqsInd),2), 0);

    % filter a window of input signal to boost at fcents
    output(:, (i-1)*winSize+1 : i*winSize) = mooneq(fcents, gain, g2(:, (i-1)*winSize+1 : i*winSize), fs, bw);
end    

% truncate output to the non 0 padded samples
output = output(1:numSamples);


end