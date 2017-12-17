
clear all;
clc;
%% Skip user inputs
gvar.set_points=input('Would you like to input your own range? (y/n) ','s');

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

descr={ 'Plot of the function: ';
gvar.raw_in;

'f(x) displayed in blue';

'f''(x) displayed in green';

'f''''(x) displayed in magenta';

'Diamond represents';
'relative min/max';

'Star represents POI';

}



text(-10,0.6,descr);


xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);



%% Time to generate the graphs
        toc

%% Trace the graph

trace_graph();

%% Calculate the FTC
FTC();

gvar.trial_number=gvar.trial_number+1;

% end