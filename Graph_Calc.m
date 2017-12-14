
function Graph_Calc()

clear all;
%% Skip user inputs
set_points=input('Would you like to input your own range? (y/n) ','s');

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
gvar.aH=axes;
xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);


set(gvar.aH,'FontName','Californian FB');

%% Start functions

deriv1();

hold on
deriv2();


gvar.axes=plot([gvar.xMin gvar.xMax],[0 0],'k');
hold on
gvar.axes=plot([0 0],[gvar.yMin gvar.yMax],'k');
hold on


relMinMax();
POI();

xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);

%% Title
title(raw_in);


%% Time to generate the graphs
        toc

%% Trace the graph

trace_graph();

%% Calculate the FTC
FTC();

gvar.trial_number=gvar.trial_number+1

% end