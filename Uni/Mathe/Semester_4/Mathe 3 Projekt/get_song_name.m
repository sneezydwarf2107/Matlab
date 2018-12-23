function songname = get_song_name(Pathname,Index)

%Index = 2;
extension = '.mp3';
%Pathname = '/Users/lukasschwoerer/Documents/OneDrive - bwedu/Datengrab/Programmieren/MatLab_2/Published/Uni/Mathe/Semester_4/Mathe 3 Projekt/Database';
search_dir = dir(Pathname);
Comperator = 0;

for n = 1:length(search_dir)
    
    if (search_dir(n).isdir)
        if (search_dir(n).name ~= '.')
            creator_name = search_dir(n).name;
            creator_dir = strcat(Pathname,'/',creator_name);
            search_creator_dir = dir(creator_dir);
            
            for m = 1:length(search_creator_dir)
    
                if (search_creator_dir(m).isdir)
                    if (search_creator_dir(m).name ~= '.')
                        album_name = search_creator_dir(m).name;
                        creator_album_dir = strcat(Pathname,'/',creator_name,'/',album_name);
                        search_creator_album_dir = dir(creator_album_dir);
                           
                            for t=1:length(search_creator_album_dir)
                                filename = search_creator_album_dir(t).name;
                                [P, N, ext] = fileparts(filename);
                                if strcmpi(ext, '.mp3')
                                    Comperator = Comperator+1;
                                    
                                    if Comperator==Index
                                        songname = strcat(search_creator_album_dir(t).name,{' '},creator_name,{' '},album_name);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

