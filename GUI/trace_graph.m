function trace_graph()

global gvar
if gvar.trial_number==1
disp('Would you like to trace the graph? (y/n)');
end
[gvar.trace_keyIsDown,gvar.trace_timeSecs,gvar.trace_keyCode] = KbCheck();
    while ~gvar.trace_keyCode(gvar.keyYes) && ~gvar.trace_keyCode(gvar.keyNo)
        [gvar.trace_keyIsDown,gvar.trace_timeSecs,gvar.trace_keyCode] = KbCheck();
    end
    clc
%% UI (clicking on points)
if gvar.trace_keyCode(gvar.keyYes)==1
     hold on
%% Click on graph variable points
     set(gvar.graph,'hittest','off'); 
     hold on;
%% Initiate getCoord when clicked
    set(gvar.aH,'ButtonDownFcn',@getCoord);
    xlim([gvar.xMin gvar.xMax]);
    ylim([gvar.yMin gvar.yMax]);
end
