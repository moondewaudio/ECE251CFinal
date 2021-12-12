[x, fs] = audioread("testinput.wav");
[~, ch] = size(x);

%ensure signal is mono
if ch ~= 1
    x = x(:,1)';
end

numHarmAdj = 4; % # of harmonics to adjust
bw = 75; % bandwidth of filters to adjust
gain = 6; % dB gain wanted in those harmonics
numVoices = 14; % how many voices per octave for the filter
winTime = 0.75;

output = cwtTrackEQ(x, fs, numHarmAdj, bw, gain, numVoices, winTime);

audiowrite("14voices.wav", output, fs);