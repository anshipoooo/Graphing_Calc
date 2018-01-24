function varargout = Calc_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Calc_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Calc_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End of initialization code


function Calc_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Default command line for the master program
handles.output = hObject;

% Updates the GUI handle structure
guidata(hObject, handles);

% Wait for user response to execute respective function
uiwait(handles.figure1);

%% Sets default colors
set(handles.figure1,'Color',[0 0 0]);


function varargout = Calc_GUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function Deriv1_PushButton_Callback(hObject, eventdata, handles)

global gvar
first_derivative();

function Deriv2_PushButton_Callback(hObject, eventdata, handles)

global gvar
second_derivative();

function FTC_PushButton_Callback(hObject, eventdata, handles)

global gvar



function domainUpper_TextBox_Callback(hObject, eventdata, handles)

global gvar
gvar.domainUpper=str2num(get(handles.domainUpper_TextBox,'string'));
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper])

function domainUpper_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
   
end
global gvar



function rangeUpper_TextBox_Callback(hObject, eventdata, handles)

global gvar
gvar.rangeUpper=str2num(get(handles.rangeUpper_TextBox,'string'));
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);

function rangeUpper_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gvar



function EquationTwo_TypeBar_Callback(hObject, eventdata, handles)

%% State global variables
global gvar
global funcParse2
global v

%% Initialization
v.value=1;
gvar.graph(1:8)=plot(1,1);
gvar.axis_plot(1:2)=plot(1,1);
delete(gvar.graph);
delete(gvar.axis_plot);
cla reset;

%% Allowing 2D graphs to be plotted first
set(handles.Two_RadioButton,'Value',1);
set(handles.variousGraphs_PopUp,'Value',1);



%% Giving a set domain and range of ±10
whos equation
gvar.xDist=0.001;
gvar.domainLower=-10;
gvar.domainUpper=10;
gvar.rangeLower=-10;
gvar.rangeUpper=10;

%% Allows user to alter the domain and range based on the text boxes

set(handles.domainLower_TextBox,'String',gvar.domainLower);
set(handles.domainUpper_TextBox,'String',gvar.domainUpper);
set(handles.rangeLower_TextBox,'String',gvar.rangeLower);
set(handles.rangeUpper_TextBox,'String',gvar.rangeUpper);

%% Initializing the boxes where graph tracing occurs
set(handles.xCoord_ToggleButton,'String','');
set(handles.yCoord_ToggleButton,'String','');

%% Allows for just the original function to be graphed when a new equation is inputted
set(handles.deriv1_CheckBox,'Value',0);
set(handles.deriv2_CheckBox,'Value',0);
set(handles.relMinMax_CheckBox,'Value',0);
set(handles.POI_CheckBox,'Value',0);

%% Sets the trial to 1
gvar.trial=1;

%% Beginning of the actual graphing

    
%% Only if the 2D button is selected, the following occurs
while get(handles.Two_RadioButton,'Value')==1 && v.value==1
        
%% Storing the raw string inputted into the textbox into the global variable
        try
            funcParse2.raw_in=get(handles.EquationTwo_TypeBar,'string');
        catch
            WaitSecs(0.000001);
        end
        try
%% Setting the x value based on the user-inputted domain
            x=gvar.domainLower:gvar.xDist:gvar.domainUpper;
            
%% Run the parser function to make raw string decodable for MatLab
            equation_parser_two()

            try
%% Evaluates the MatLab-friendly function
                y=eval(funcParse2.format_in);
%                 break
            catch

                WaitSecs(0.0000001);
            end

        catch
            WaitSecs(0.000001);
        end

% end


%% Only real numbers allowed
gvar.num_y=(y==real(y));
gvar.real_orig_y=y(gvar.num_y);
gvar.real_orig_x=x(gvar.num_y);

%% Executes functions to find the values of f(x), f'(x), and f''(x) and store in respective variables
Orig_function();
first_derivative();
second_derivative();
findZeros();

%% Puts the important points in their respective boxes (zeros, RMM, and POI)
set(handles.zeros_ListBox,'string',gvar.zeros_str);
set(handles.zeros_ListBox,'max',length(gvar.zeros_str));
relMinMax()
set(handles.relMinMax_ListBox,'string',gvar.RMM_str)
set(handles.relMinMax_ListBox,'max',length(gvar.RMM_str));
POI();
set(handles.POI_ListBox,'string',gvar.POI_str);
set(handles.POI_ListBox,'max',length(gvar.POI_str));

%% Sets the axes on the graph
axis([gvar.domainLower gvar.domainUpper gvar.rangeLower gvar.rangeUpper]);
gvar.axis_plot(1)=plot([gvar.domainLower gvar.domainUpper],[0 0],'k');
hold on
gvar.axis_plot(2)=plot([0 0],[gvar.rangeLower gvar.rangeUpper],'k');
hold on
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);
gvar.valueRMM=0;
gvar.valuePOI=0;
     hold on
     


%% Click on graph variable points
     set(gvar.graph(1),'hittest','off'); 
%% Initiate getCoord when clicked, displayed in the boxes at the botton of the window


    set(handles.Axes_GraphAxes,'ButtonDownFcn',@getCoord);
    
    if gvar.trial==1
       gvar.xValue=0;
       gvar.yValue=0;
    end
    set(handles.xCoord_ToggleButton,'String',gvar.xValue);
    
    set(handles.yCoord_ToggleButton,'String',gvar.yValue);
    waitforbuttonpress;
    
    
    gvar.trial=gvar.trial+1;
end




function EquationTwo_TypeBar_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gvar



function domainLower_TextBox_Callback(hObject, eventdata, handles)

global gvar
%% Gets the lower domain value and stores into a variable
gvar.domainLower=str2num(get(handles.domainLower_TextBox,'string'));
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);

function domainLower_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rangeLower_TextBox_Callback(hObject, eventdata, handles)
%% Gets the lower range value and stores into a variable
global gvar
gvar.rangeLower=str2num(get(handles.rangeLower_TextBox,'string'));
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);

function rangeLower_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function deriv1_CheckBox_Callback(hObject, eventdata, handles)
%% When the first derivative button is checked, plot f'(x)
global gvar
gvar.value1=get(handles.deriv1_CheckBox,'Value');
delete(gvar.graph(2));
if gvar.value1==1
    first_derivative_plot();
end

function deriv2_CheckBox_Callback(hObject, eventdata, handles)
%% When the second derivative button is checked, plot f''(x)
global gvar
gvar.value2=get(handles.deriv2_CheckBox,'Value');
    delete(gvar.graph(3));
if gvar.value2==1
    second_derivative_plot();
end

function FTC_LowBound_TextBox_Callback(hObject, eventdata, handles)
%% Finding and plotting the area under f'(x)
global gvar
delete(gvar.graph(6));

%% Get the user input for the lower bound of f'(x)
gvar.init_low_bound=get(handles.FTC_LowBound_TextBox,'string');

%% Make string MatLab-friendly
FTC_Parser_Low();
try
%% Find the area under the curve and plot values in the toggle boxes
    FTC();
    set(handles.areaUnder_Toggle,'Value',1);
    set(handles.ftcProof_Toggle,'Value',1);
    set(handles.areaUnder_Toggle,'String',gvar.final_value);
    set(handles.ftcProof_Toggle,'String',gvar.orig_area);
    hold on
%% Plot the area of the region given
gvar.graph(6)=area(gvar.real_orig_x(1,gvar.loc_lower:gvar.loc_up),...
    gvar.real_first(1,gvar.loc_lower:gvar.loc_up));
catch 
    pause(0.00001);
end

function FTC_LowBound_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FTC_UpBound_TextBox_Callback(hObject, eventdata, handles)
%% Finding and plotting area under f'(x)
global gvar
delete(gvar.graph(6));

%% Get user input for the upper bound of f'(x)
gvar.init_up_bound=get(handles.FTC_UpBound_TextBox,'string');
%% Make string MatLab-friendly
FTC_Parser_Up();

try
%% Find the area under the curve and plot values in the toggle boxes
    FTC();
    set(handles.areaUnder_Toggle,'Value',1);
    set(handles.ftcProof_Toggle,'Value',1);
    set(handles.areaUnder_Toggle,'String',gvar.final_value);
    set(handles.ftcProof_Toggle,'String',gvar.orig_area);
    hold on
    
%% Plot the area of the region given
    gvar.graph(6)=area(gvar.real_orig_x(1,gvar.loc_lower:gvar.loc_up),...
        gvar.real_first(1,gvar.loc_lower:gvar.loc_up));
catch
    pause(0.00000001);
end

function FTC_UpBound_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function areaUnder_Toggle_Callback(hObject, eventdata, handles)

global gvar
set(handles.areaUnder_Toggle,'String',gvar.final_value);

function ftcProof_Toggle_Callback(hObject, eventdata, handles)

global gvar
set(handles.ftcProof_Toggle,'String',gvar.orig_area);

function relMinMax_CheckBox_Callback(hObject, eventdata, handles)

global gvar
%% Plot the relative maximums and minimums if the box is checked
gvar.valueRMM=get(handles.relMinMax_CheckBox,'Value');
if gvar.valueRMM==1
    relMinMax_plot();
elseif gvar.valueRMM==0
    delete(gvar.graph(4));
end

function POI_CheckBox_Callback(hObject, eventdata, handles)

global gvar
%% Plot the points of inflection if the box is checked
gvar.value_POI=get(handles.POI_CheckBox,'Value');
if gvar.value_POI==1
    POI_plot();
elseif gvar.value_POI==0
    delete(gvar.graph(5));
end

function POI_ListBox_Callback(hObject, eventdata, handles)

global gvar
%% Display all the points of inflection within the box
set(handles.POI_ListBox,'string',gvar.POI_str);
set(handles.POI_ListBox,'max',length(gvar.POI_str));

function POI_ListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zeros_ListBox_Callback(hObject, eventdata, handles)

global gvar
%% Display all the zeros within the box
set(handles.zeros_ListBox,'string',gvar.zeros_str);
set(handles.zeros_ListBox,'max',length(gvar.zeros_str));


function zeros_ListBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function relMinMax_ListBox_Callback(hObject, eventdata, handles)
global gvar

function relMinMax_ListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xCoord_ToggleButton_Callback(hObject, eventdata, handles)

global gvar
%% Set the x and y value if a point is clicked on the graph
set(handles.Axes_GraphAxes,'ButtonDownFcn',@getCoord);
set(handles.xCoord_ToggleButton,'String',gvar.xValue);
set(handles.yCoord_ToggleButton,'String',gvar.yValue);

function yCoord_ToggleButton_Callback(hObject, eventdata, handles)
global gvar


function variousGraphs_PopUp_Callback(hObject, eventdata, handles)
%% Defining the global variables being used in the box that contains interesting graphs
global gvar
global v
global funcParse2
global funcParse3


set(handles.EquationTwo_TypeBar,'String','');

set(handles.EquationThree_TypeBar,'String','');

%% Initialize the new axes to plot on

delete(gvar.graph(7));
v.value=get(handles.variousGraphs_PopUp,'Value');
set(handles.EquationTwo_TypeBar,'String','');
set(handles.EquationThree_TypeBar,'String','');

axes(handles.Axes_GraphAxes);
hold off
%% Initial choosing value
if v.value==1
    
    if get(handles.Two_RadioButton,'Value')==1
    set(handles.EquationTwo_TypeBar,'String',funcParse2.format_in);
    EquationTwo_TypeBar_Callback(handles.EquationTwo_TypeBar,eventdata,handles);
    elseif get(handles.Three_RadioButton,'Value')==1
    set(handles.EquationThree_TypeBar,'String',funcParse3.format_in);
    EquationThree_TypeBar_Callback(handles.EquationThree_TypeBar,eventdata,handles);
    end

%% Gaussian distribution of 3D peaks
elseif v.value==2
%     delete(gvar.graph(7));
    plot([0 0],[0 0]);
    gvar.graph(7)=surf(peaks);
%% MatLab logo
elseif v.value==3
%     delete(gvar.graph(7));
    plot([0 0],[0 0]);  
    gvar.graph(7)=surf(membrane);
%% Inverse Fourier transform of a rectangular pulse given sine
elseif v.value==4
%     delete(gvar.graph(7));
    plot([0 0],[0 0]);
    [x,y]=meshgrid(-8:0.5:8);
    r=sqrt(x.^2+y.^2)+eps;
    sinc=sin(r)./r;
    gvar.graph(7)=surf(sinc);
%% Inverse Fourier Transform of a rectangular pulse given cosine
elseif v.value==5
%     delete(gvar.graph(7));
    [x,y]=meshgrid(-8:0.5:8);
    r=sqrt(x.^2+y.^2)+eps;
    cosc=cos(r)./r;
    gvar.graph(7)=surf(cosc);

%% Graph of y=x!
elseif v.value==6
%     delete(gvar.graph(7));
    setAxes();
    
    
    
    x=gvar.domainLower:gvar.xDist:gvar.domainUpper;
    y=gamma(x);
    

    
    gvar.graph(7)=plot(x,y);
    hold on;
    
    gvar.num_y=(y==real(y));
    gvar.real_orig_y=y(gvar.num_y);
    gvar.real_orig_x=x(gvar.num_y); 
    
    first_derivative();
    second_derivative();
    
    findZeros();
    set(handles.zeros_ListBox,'string',gvar.zeros_str);
    set(handles.zeros_ListBox,'max',length(gvar.zeros_str));
    relMinMax()
    set(handles.relMinMax_ListBox,'string',gvar.RMM_str)
    set(handles.relMinMax_ListBox,'max',length(gvar.RMM_str));
    POI();
    set(handles.POI_ListBox,'string',gvar.POI_str);
    set(handles.POI_ListBox,'max',length(gvar.POI_str));
    
    
    set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);
    set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);
%% Graph of the amplitude modulation function (commonly known as AM radio signal)
elseif v.value==7
%     delete(gvar.graph(7));

    
    x=gvar.domainLower:gvar.xDist:gvar.domainUpper;
    y=eval('exp(0.15.*x).*(sin(2.*x))-2');
    
    gvar.num_y=(y==real(y));
    gvar.real_orig_y=y(gvar.num_y);
    gvar.real_orig_x=x(gvar.num_y); 

    
    gvar.graph(7)=plot(x,y);
    
    first_derivative();
    second_derivative();
    
    findZeros();
    set(handles.zeros_ListBox,'string',gvar.zeros_str);
    set(handles.zeros_ListBox,'max',length(gvar.zeros_str));
    relMinMax()
    set(handles.relMinMax_ListBox,'string',gvar.RMM_str)
    set(handles.relMinMax_ListBox,'max',length(gvar.RMM_str));
    POI();
    set(handles.POI_ListBox,'string',gvar.POI_str);
    set(handles.POI_ListBox,'max',length(gvar.POI_str));
    
    
    
    hold on
    grid on
    setAxes();
    set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);
    set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);
%% Popup that shows a wave
elseif v.value==8
%     delete(gvar.graph(7));
    vibes
%% Popup that allows users to customize a teapot
elseif v.value==9
%     delete(gvar.graph(7));
    teapotdemo;
%% Popup that allows users to make a vase by plotting points
elseif v.value==10
    delete(gvar.graph(7));
    makevase;
%% Popup game where users try to make a numerical order in a puzzle
elseif v.value==11
    delete(gvar.graph(7));
    fifteen;
%% Popup memorization game
elseif v.value==12
    delete(gvar.graph(7));
    soma;

    
end


function variousGraphs_PopUp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Two_RadioButton_Callback(hObject, eventdata, handles)

global gvar
hold off
cla

%% Put the 2D equation textbox in front
uistack(handles.EquationThree_TypeBar,'bottom');

uistack(handles.EquationTwo_TypeBar,'top');

function Three_RadioButton_Callback(hObject, eventdata, handles)

global gvar
hold off
cla

%% Clears all of the values in the listboxes
set(handles.zeros_ListBox,'String','');
set(handles.relMinMax_ListBox,'String','');
set(handles.POI_ListBox,'String','');
set(handles.xCoord_ToggleButton,'String','');
set(handles.yCoord_ToggleButton,'String','');

%% Puts the 3D equation textbox in front
uistack(handles.EquationTwo_TypeBar,'bottom');

uistack(handles.EquationThree_TypeBar,'top');


function EquationThree_TypeBar_Callback(hObject, eventdata, handles)

global gvar
global funcParse3
set(handles.Two_RadioButton,'Value',1);
set(handles.variousGraphs_PopUp,'Value',1);
hold off
[x,y]=meshgrid(-8:0.3:8);
%% Gets the raw user input
    funcParse3.raw_in=get(handles.EquationThree_TypeBar,'String');
%% Alters the string to make it MatLab-friendly
    equation_parser_three();
%% Graphs the 3D function based on the MatLab-friendly model
    gvar.graph(8)=ezsurf(funcParse3.format_in);
    

function EquationThree_TypeBar_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
