[x, fs] = audioread("testinput.wav");
[~, ch] = size(x);

%ensure signal is mono
if ch ~= 1
    x = x(:,1)';
end

numHarmAdj = 4; % # of harmonics to adjust
bw = 75; % bandwidth of filters applied to the harmonics
gain = 6; % dB gain wanted in those harmonics (can be negative)
numVoices = 10; % how many voices per octave for the filter
winTime = 0.75; % how long should the EQ latch for between switches

output = cwtTrackEQ(x, fs, numHarmAdj, bw, gain, numVoices, winTime);

audiowrite("14voices.wav", output, fs);