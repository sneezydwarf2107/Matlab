figure('WindowKeyPressFcn', @KeyPressCB);
function KeyPressCB(~, EventData)
disp(EventData.Key)
end