function trace_graph()

global gvar

%% UI (clicking on points)

     hold on
%% Click on graph variable points
     set(gvar.graph,'hittest','off'); 
     hold on;
%% Initiate getCoord when clicked
    set(handles.Axes_GraphAxes,'ButtonDownFcn',@getCoord);
    xlim([gvar.xMin gvar.xMax]);
    ylim([gvar.yMin gvar.yMax]);
end
