%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read all MP3 files in 'dir' and add them to the database training if they
% are not already in 'songid'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define Variables
Pathname = '/Users/lukasschwoerer/Documents/OneDrive - bwedu/Datengrab/Programmieren/MatLab_2/Published/Uni/Mathe/Semester_4/Mathe 3 Projekt/Database'; %Change this to the Path where u want to create ur database from 
hashTableSize = 1000000; % This can be adjusted. Setting it too small will cause more accidental collisions.
global hashtable
% Create new database
songid = cell(0);
hashtable = cell(hashTableSize,2); % 
songIndex = length(songid); % This becomes the song ID number.

%% Add songs to songid and fingerprints to hashtable
search_dir = dir(Pathname);
for n = 1:length(search_dir)
    
    if (search_dir(n).isdir) %Get every dir in Database
        if (search_dir(n).name ~= '.') % Eliminate all navigation entries
            creator_name = search_dir(n).name; %Save name of the Crator
            creator_dir = strcat(Pathname,'/',creator_name); %complete the new path for searching album's
            search_creator_dir = dir(creator_dir);
            
            for m = 1:length(search_creator_dir) %Restart the searching progress for the album dir 
    
                if (search_creator_dir(m).isdir)
                    if (search_creator_dir(m).name ~= '.')
                        album_name = search_creator_dir(m).name;
                        creator_album_dir = strcat(Pathname,'/',creator_name,'/',album_name);
                                
                        songs = getMp3List(creator_album_dir); %Looking for Mp3's in the aktual directory 

                        for i = 1:length(songs) %start machiening the found Songs and adding them to the database 

                            songIndex = songIndex + 1;
                            filename = strcat(creator_album_dir,'/',songs{i});
                            disp(filename); %For control purpose display the actual song info u can comment that out if u want
                            
                            % Your code here (use fingerprint, convert_to_pairs and add_to_table)
                            
                            peaks = fingerprint(filename,44100);
                            tuple = convert_to_pairs(peaks);
                            max_Collisons = add_to_table(tuple, songIndex);
                            songid{songIndex,1} = strcat(songs{i},{'\'},creator_name,{'\'},album_name);

                        end
                    end
                end
            end
        end
    end
end


global numSongs
numSongs = songIndex;

%% Save the global Variables

save('SONGID.mat', 'songid');
save('HASHTABLE.mat', 'hashtable');
