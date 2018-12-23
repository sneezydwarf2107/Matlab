%% Defining Variables


%% Calculations
for i = 1:1:height(a)
    for j = 1:1:3
        
        if contains(a{i,j},'X')
            a{i,j} = regexprep(a{i,j},'X','');
            a{i,j} = regexprep(a{i,j},',','');
        end
        
        if contains(a{i,j},'Y')
            a{i,j} = regexprep(a{i,j},'Y','');
            a{i,j} = regexprep(a{i,j},',','');
        end
        
        if contains(a{i,j},'Z')
            a{i,j} = regexprep(a{i,j},'Z','');
            a{i,j} = regexprep(a{i,j},',','');
        end
    end
end

%% Output