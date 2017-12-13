
clear all
%% Skip user inputs
set_points=input('Would you like to input your own range? (y/n) ','s');

%% Start prompt
global gvar;
clc;
if set_points=='y'
    gvar.xMin_In=input('Declare x min: ','s');
    gvar.xMax_In=input('Declare x max: ','s');
    gvar.xMin=str2num(gvar.xMin_In);
    gvar.xMax=str2num(gvar.xMax_In);
    gvar.xDist=0.0001;
    gvar.yMin_In=input('Declare y min: ','s');
    gvar.yMax_In=input('Declare y max: ','s');
    gvar.yMin=str2num(gvar.yMin_In);
    gvar.yMax=str2num(gvar.yMax_In);
elseif set_points=='n'
    gvar.xMin=-10;
    gvar.xMax=10;
    gvar.xDist=0.001;
    gvar.yMin=-10;
    gvar.yMax=10;
end
%% x Range
x=gvar.xMin:gvar.xDist:gvar.xMax;


%% Initialize trial number
gvar.trial_number=1;

while true

%% Convert user input into function --> previously Graphing_Calc
    raw_in=input('Enter equation in terms of x: ','s');
    format_in=strrep(raw_in,'*','.*');

    if ~contains(raw_in,'e^')
    format_in=strrep(format_in,'^','.^');
    end
    format_in=strrep(format_in,'/','./');
    format_in=strrep(format_in,'+-','-');


%% Exponential functions
if contains(raw_in,'e^')
    exp_split=strsplit(format_in,'e^')
    exp_in=strcat('exp(',exp_split{2},')')
    format_in=strcat(exp_split{1},exp_in,exp_split{3});
end
%% Absolute value change

if contains(raw_in,'|')
    abs_split=strsplit(format_in,'|');
    abs_in=strcat('abs(',abs_split{2},')');
    format_in=strcat(abs_split{1},abs_in,abs_split{3});
end
    y=eval(format_in);

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

stop printing;
gvar.trial_number=gvar.trial_number+1

end