function trace_graph()

global gvar

%% UI (clicking on points)
if gvar.tracing_input == 'y'
     hold on
%% Click on graph variable points
     set(gvar.graph,'hittest','off'); 
     hold on;
%% Initiate getCoord when clicked
    set(gvar.aH,'ButtonDownFcn',@getCoord);
    xlim([gvar.xMin gvar.xMax]);
    ylim([gvar.yMin gvar.yMax]);
end


