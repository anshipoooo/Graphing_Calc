% clc;
% close all
% clear all

%% TODO
% Absolute Value
% Slider on the graph --> getCoord function inclusion

% KbName('UnifyKeyNames');
% enter_code=KbName('return');
% [a,b,keyCode]=KbCheck;
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
    gvar.xDist=0.001;
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
%% Convert user input into function --> previously Graphing_Calc
    raw_in=input('Enter equation in terms of x: ','s');
    format_in=strrep(raw_in,'*','.*');
    format_in=strrep(format_in,'e^','exp');
    format_in=strrep(format_in,'^','.^');
    format_in=strrep(format_in,'/','./');
    format_in=strrep(format_in,'+-','-');
    format_in=strrep(format_in,'+(','-(');
    y=eval(format_in);

%% Real Numbers
%%Real numbers
gvar.num_y=(y==real(y));
gvar.real_orig_y=y(gvar.num_y);
gvar.real_orig_x=x(gvar.num_y);
close all

tic;
%% User graph prompts
        

        

        gvar.tracing_input=input('Would you like to trace the graph? (y/n): ','s');

        gvar.ftc_input=input('Would you like to calculate the FTC? (y/n): ','s');
        gvar.deriv1_q=input('1st derivative (y/n): ','s');
        gvar.deriv2_q=input('2nd derivative (y/n): ','s');


%% axes
gvar.aH=axes;
xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);

%% X and Y line
% gvar.axes=axis([gvar.xMin gvar.xMax gvar.yMin gvar.yMax]);
gvar.axes=plot([gvar.xMin gvar.xMax],[0 0],'k');
hold on
gvar.axes=plot([0 0],[gvar.yMin gvar.yMax],'k');
hold on
set(gvar.axes,'Visible','off');
deriv1();
set(gvar.graph,'Visible','off');
hold on
deriv2();
set(gvar.graph,'Visible','on');
set(gvar.axes,'Visible','on');


relMinMax();
POI();

xlim([gvar.xMin gvar.xMax]);
ylim([gvar.yMin gvar.yMax]);

%% Title
title(raw_in);


%% Time to generate the graphs
        toc

%% Trace the graph

% trace_graph();
%% UI (clicking on points)
if gvar.tracing_input == 'y'
     hold on
%% Click on graph variable points
    %  set(gvar.graph,'hittest','off'); 
    %  hold on;
%% Initiate getCoord when clicked
    set(gvar.aH,'ButtonDownFcn',@getCoord);
    xlim([gvar.xMin gvar.xMax]);
    ylim([gvar.yMin gvar.yMax]);
end

%% Calculate the FTC
FTC();




% 
% while true
%     orig.XDataSource='x';
%     orig.YDataSource='y';
%     
% 
%     
% 

