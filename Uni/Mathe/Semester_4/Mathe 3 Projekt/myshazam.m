% Make a recording of a song

duration = 5; % Seconds

global hashtable

% Check if we have a database in the workspace
if ~exist('songid')
    % Load database if one exists
    if exist('SONGID.mat')
        load('SONGID.mat');
        load('HASHTABLE.mat');
    else  
        msgbox('No song database');
        return;
    end
end

global numSongs
numSongs = length(songid);


% Settings used for recording.
fs = 44100; % Sample frequency
bits = 16;  % Bits used per sample

% Record audio for <duration> seconds.
recObj = audiorecorder(fs, bits, 1);
handle1 = msgbox('Recording');
recordblocking(recObj, duration);
delete(handle1);

% Store data in Double-precision array.
sound = getaudiodata(recObj);

% INSERT CODE HERE
[bestMatchID, confidence] =  match_segment(sound,fs);
answer                    =  songid(bestMatchID);
answer_string             =  char(answer{1});
answer_string             =  strsplit(answer_string,'\\');
answer_string{1,3}        =  strcat('Album:',{' '},answer_string{1,3});
confidence                =  confidence;
creator                   =  char(answer_string{1,2});
song                      =  char(answer_string{1,1});
album                     =  char(answer_string{1,3});


msgbox({creator;song;album});

