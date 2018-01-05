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

global gvar
global funcParse2
gvar.graph(1:8)=plot(1,1);
gvar.axis_plot(1:2)=plot(1,1);
delete(gvar.graph);
delete(gvar.axis_plot);
cla reset;

set(handles.Two_RadioButton,'Value',1);





whos equation
gvar.xDist=0.001;
gvar.domainLower=-10;
gvar.domainUpper=10;
gvar.rangeLower=-10;
gvar.rangeUpper=10;

set(handles.domainLower_TextBox,'String',gvar.domainLower);
set(handles.domainUpper_TextBox,'String',gvar.domainUpper);
set(handles.rangeLower_TextBox,'String',gvar.rangeLower);
set(handles.rangeUpper_TextBox,'String',gvar.rangeUpper);

set(handles.xCoord_ToggleButton,'String','');
set(handles.yCoord_ToggleButton,'String','');

gvar.trial=1;

while true
    if get(handles.Two_RadioButton,'Value')==1

        try
            funcParse2.raw_in=get(handles.EquationTwo_TypeBar,'string');
        catch
            WaitSecs(0.000001);
        end
        try
            x=gvar.domainLower:gvar.xDist:gvar.domainUpper;
            equation_parser_two()

            try
                y=eval(funcParse2.format_in);
%                 break
            catch

                WaitSecs(0.0000001);
            end

        catch
            WaitSecs(0.000001);
        end

% end



gvar.num_y=(y==real(y));
gvar.real_orig_y=y(gvar.num_y);
gvar.real_orig_x=x(gvar.num_y);


Orig_function();
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
%% Initiate getCoord when clicked


    set(handles.Axes_GraphAxes,'ButtonDownFcn',@getCoord);
    
    if gvar.trial==1
       gvar.xValue=0;
       gvar.yValue=0;
    end
    set(handles.xCoord_ToggleButton,'String',gvar.xValue);
    
    set(handles.yCoord_ToggleButton,'String',gvar.yValue);
    waitforbuttonpress;
    
    
    gvar.trial=gvar.trial+1;
    else
        break
    end
end



function EquationTwo_TypeBar_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gvar



function domainLower_TextBox_Callback(hObject, eventdata, handles)

global gvar
gvar.domainLower=str2num(get(handles.domainLower_TextBox,'string'));
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);

function domainLower_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rangeLower_TextBox_Callback(hObject, eventdata, handles)

global gvar
gvar.rangeLower=str2num(get(handles.rangeLower_TextBox,'string'));
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);

function rangeLower_TextBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function deriv1_CheckBox_Callback(hObject, eventdata, handles)

global gvar
gvar.value1=get(handles.deriv1_CheckBox,'Value');
delete(gvar.graph(2));
if gvar.value1==1
    first_derivative_plot();
end

function deriv2_CheckBox_Callback(hObject, eventdata, handles)

global gvar
gvar.value2=get(handles.deriv2_CheckBox,'Value');
    delete(gvar.graph(3));
if gvar.value2==1
    second_derivative_plot();
end

function FTC_LowBound_TextBox_Callback(hObject, eventdata, handles)

global gvar
delete(gvar.graph(6));
gvar.init_low_bound=get(handles.FTC_LowBound_TextBox,'string');
FTC_Parser_Low;
try
    FTC();
    set(handles.areaUnder_Toggle,'Value',1);
    set(handles.ftcProof_Toggle,'Value',1);
    set(handles.areaUnder_Toggle,'String',gvar.final_value);
    set(handles.ftcProof_Toggle,'String',gvar.orig_area);
    hold on
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

global gvar
delete(gvar.graph(6));
gvar.init_up_bound=get(handles.FTC_UpBound_TextBox,'string');

FTC_Parser_Up;

try
    FTC();
    set(handles.areaUnder_Toggle,'Value',1);
    set(handles.ftcProof_Toggle,'Value',1);
    set(handles.areaUnder_Toggle,'String',gvar.final_value);
    set(handles.ftcProof_Toggle,'String',gvar.orig_area);
    hold on
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

gvar.valueRMM=get(handles.relMinMax_CheckBox,'Value');
if gvar.valueRMM==1
    relMinMax_plot();
elseif gvar.valueRMM==0
    delete(gvar.graph(4));
end

function POI_CheckBox_Callback(hObject, eventdata, handles)

global gvar
gvar.value_POI=get(handles.POI_CheckBox,'Value');
if gvar.value_POI==1
    POI_plot();
elseif gvar.value_POI==0
    delete(gvar.graph(5));
end

function POI_ListBox_Callback(hObject, eventdata, handles)

global gvar

set(handles.POI_ListBox,'string',gvar.POI_str);
set(handles.POI_ListBox,'max',length(gvar.POI_str));

function POI_ListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zeros_ListBox_Callback(hObject, eventdata, handles)

global gvar
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
set(handles.Axes_GraphAxes,'ButtonDownFcn',@getCoord);
set(handles.xCoord_ToggleButton,'String',gvar.xValue);
set(handles.yCoord_ToggleButton,'String',gvar.yValue);

function yCoord_ToggleButton_Callback(hObject, eventdata, handles)
global gvar


function variousGraphs_PopUp_Callback(hObject, eventdata, handles)
% hObject    handle to variousGraphs_PopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
global v

delete(gvar.graph(7));
v.value=get(handles.variousGraphs_PopUp,'Value');
hold off

if v.value==2
    delete(gvar.graph(7));
    gvar.graph(7)=surf(peaks);
elseif v.value==3
    delete(gvar.graph(7));
    gvar.graph(7)=surf(membrane);
elseif v.value==4
    delete(gvar.graph(7));
    [x,y]=meshgrid(-8:0.5:8);
    r=sqrt(x.^2+y.^2)+eps;
    sinc=sin(r)./r;
    gvar.graph(7)=surf(sinc);
    
elseif v.value==5
    delete(gvar.graph(7));
    [x,y]=meshgrid(-8:0.5:8);
    r=sqrt(x.^2+y.^2)+eps;
    cosc=cos(r)./r;
    gvar.graph(7)=surf(cosc);

    
elseif v.value==6
    delete(gvar.graph(7));
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
elseif v.value==7
    delete(gvar.graph(7));

    
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
elseif v.value==8
    delete(gvar.graph(7));
    vibes
    
elseif v.value==9
    delete(gvar.graph(7));
    teapotdemo;
    
elseif v.value==10
    delete(gvar.graph(7));
    makevase;
    
elseif v.value==11
    delete(gvar.graph(7));
    fifteen;
    
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


uistack(handles.EquationThree_TypeBar,'bottom');
uistack(handles.EquationTwo_TypeBar,'top');

function Three_RadioButton_Callback(hObject, eventdata, handles)

global gvar
hold off
cla
set(handles.zeros_ListBox,'String','');
set(handles.relMinMax_ListBox,'String','');
set(handles.POI_ListBox,'String','');
set(handles.xCoord_ToggleButton,'String','');
set(handles.yCoord_ToggleButton,'String','');
uistack(handles.EquationTwo_TypeBar,'bottom');
uistack(handles.EquationThree_TypeBar,'top');


function EquationThree_TypeBar_Callback(hObject, eventdata, handles)

global gvar
global funcParse3
hold off
[x,y]=meshgrid(-8:0.3:8);
    funcParse3.raw_in=get(handles.EquationThree_TypeBar,'String');
    equation_parser_three();
    gvar.graph(8)=ezsurf(funcParse3.format_in);
    

function EquationThree_TypeBar_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
