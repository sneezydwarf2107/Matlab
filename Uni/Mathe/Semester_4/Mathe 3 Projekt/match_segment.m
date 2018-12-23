function [bestMatchID, confidence] = match_segment(clip, fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This function requires the global variables 'hashtable' and 'numSongs'
%  in order to work properly.
%
%  This function is currently incomplete.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global hashtable
global numSongs
%%clip = '1-01_AW_testclip.mp3';
%%fs = 44100;
hashTableSize = size(hashtable,1);


% Find peak pairs from the clip

% INSERT CODE HERE
clipPeaks = fingerprint(clip, fs);
clipTuples = convert_to_pairs(clipPeaks);

% Construct the cell of matches
matches = cell(1,numSongs);
for k = 1:size(clipTuples, 1)
    clipHash = simple_hash(clipTuples(k,3),clipTuples(k,4), clipTuples(k,2)-clipTuples(k,1), hashTableSize);
    
    % If an entry exists with this hash, find the song(s) with matching peak pairs
    if (~isempty(hashtable{clipHash, 1}))
        matchID = hashtable{clipHash, 1}; % row vector of collisions
        matchTime = hashtable{clipHash, 2}; % row vector of collisions
        
        % Calculate the time difference between clip pair and song pair
        % Your Code here
        time_difference = matchTime-clipTuples(k,1);
        
        % Add matches to the lists for each individual song
        for n = 1:numSongs
            match_list = 0;
            match_list = find (matchID==n);
            match_list_dimensions = length(match_list);
            
            if (match_list_dimensions == 1)
                
                matches{n} = [matches{n},time_difference];  
                
            end
            
            if (match_list_dimensions >= 1)
                
                for e= 1:match_list_dimensions
                    
                   matches{n} = [matches{n}, time_difference(match_list(e))];
                    
                end  
            end
        end
    end
end


% Find the counts of the mode of the time offset array for each song
% Your Code here
most_common = 0;
count = 0;
best_match_time = 0;
best_match_count = 0;

for e=1:numSongs
        
    [most_common,count] = mode(matches{e});
    
    if count > best_match_count
        best_match_time = most_common;
        best_match_count = count;
        bestMatchID = e;
    end
    

    
end

% Song decision (you can skip confidence)
% Your Code here
confidence = 1.0;


optional_plot = 0; % turn plot on or off

if optional_plot
    figure(3)
    clf
    y = zeros(length(matches),1);
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        hist(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        axis([-inf, inf, 0, max(y)])
    end

    subplot(length(matches),1,1)
    title('Histogram of offsets for each song')
end

end

