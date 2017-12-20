
clear all;
clc;

KbName('UnifyKeyNames');
gvar.keyEnter=KbName('Return');
gvar.keyDelete=KbName('DELETE');
gvar.keyYes=KbName('y');
gvar.keyNo=KbName('n');




%% Start prompt
global gvar;
clc;

ranges();

%% x Range
x=gvar.xMin:gvar.xDist:gvar.xMax;


%% Initialize trial number
gvar.trial_number=1;

% while true

%% Evaluate the function

equation_parser();
    y=eval(gvar.format_in);

%% Real Numbers
gvar.num_y=(y==real(y));
gvar.real_orig_y=y(gvar.num_y);
gvar.real_orig_x=x(gvar.num_y);
close all

tic;
        


%% axes
% set(0,'DefaultFigureVisible','off');


%% Start functions

deriv1();

hold on



gvar.axes=plot([gvar.xMin gvar.xMax],[0 0],'k');
hold on
gvar.axes=plot([0 0],[gvar.yMin gvar.yMax],'k');
hold on


relMinMax();
POI();

%% Describing the lines

xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);


clc;
%% Time to generate the graphs
        toc

%% Trace the graph

trace_graph();
WaitSecs(0.5);
%% Calculate the FTC
FTC();

gvar.trial_number=gvar.trial_number+1;

% end