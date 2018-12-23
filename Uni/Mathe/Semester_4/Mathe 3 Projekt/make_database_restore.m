%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read all MP3 files in 'dir' and add them to the database training if they
% are not already in 'songid'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dir = '/Users/lukasschwoerer/Documents/OneDrive - bwedu/Datengrab/Programmieren/MatLab_2/Published/Uni/Mathe/Semester_4/Mathe 3 Projekt/Database/Amy Winehouse/Frank'; % This is the folder that the MP3 files must be placed in.
songs = getMp3List(dir);

hashTableSize = 1000000; % This can be adjusted. Setting it too small will cause more accidental collisions.

global hashtable


% Create new database
songid = cell(0);
hashtable = cell(hashTableSize,2); % 

songIndex = length(songid); % This becomes the song ID number.

% Add songs to songid and fingerprints to hashtable

for i = 1:length(songs)
   
    songIndex = songIndex + 1;
    filename = strcat(dir, filesep, songs{i});
    [sound,fs] = audioread(filename);
    sound = 0.5*(sound(:,1)+sound(:,2));
    % Your code here (use fingerprint, convert_to_pairs and add_to_table)
    peaks = fingerprint(sound,8000);
    tuple = convert_to_pairs(peaks);
    max_Collisons = add_to_table(tuple, songIndex);
    songid{songIndex,1} = songs{i};
    
end

global numSongs
numSongs = songIndex;

save('SONGID.mat', 'songid');
save('HASHTABLE.mat', 'hashtable');
