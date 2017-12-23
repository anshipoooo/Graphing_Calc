function varargout = Calc_GUI(varargin)

% CALC_GUI MATLAB code for Calc_GUI.fig
%      CALC_GUI, by itself, creates a new CALC_GUI or raises the existing
%      singleton*.
%
%      H = CALC_GUI returns the handle to a new CALC_GUI or the handle to
%      the existing singleton*.
%
%      CALC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALC_GUI.M with the given input arguments.
%
%      CALC_GUI('Property','Value',...) creates a new CALC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Calc_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Calc_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Calc_GUI

% Last Modified by GUIDE v2.5 20-Dec-2017 08:42:08

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before Calc_GUI is made visible.
function Calc_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Calc_GUI (see VARARGIN)


% Choose default command line output for Calc_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Calc_GUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Calc_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Deriv1_PushButton.
function Deriv1_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to Deriv1_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
first_derivative();


% --- Executes on button press in Deriv2_PushButton.
function Deriv2_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to Deriv2_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
second_derivative();


% --- Executes on button press in FTC_PushButton.
function FTC_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to FTC_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar



function domainUpper_Callback(hObject, eventdata, handles)
% hObject    handle to domainUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.domainUpper=str2num(get(handles.domainUpper,'string'));
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper])


% Hints: get(hObject,'String') returns contents of domainUpper as text
%        str2double(get(hObject,'String')) returns contents of domainUpper as a double


% --- Executes during object creation, after setting all properties.
function domainUpper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to domainUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
   
end
global gvar



function rangeUpper_Callback(hObject, eventdata, handles)
% hObject    handle to rangeUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.rangeUpper=str2num(get(handles.rangeUpper,'string'));
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);

% Hints: get(hObject,'String') returns contents of rangeUpper as text
%        str2double(get(hObject,'String')) returns contents of rangeUpper as a double


% --- Executes during object creation, after setting all properties.
function rangeUpper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gvar



function Equation_TypeBar_Callback(hObject, eventdata, handles)
% hObject    handle to Equation_TypeBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
delete(gvar.graph);
cla reset;

gvar.raw_in=get(handles.Equation_TypeBar,'string');
whos equation
gvar.xDist=0.0001;
x=gvar.domainLower:gvar.xDist:gvar.domainUpper;
equation_parser()
y=eval(gvar.format_in);

gvar.num_y=(y==real(y));
gvar.real_orig_y=y(gvar.num_y);
gvar.real_orig_x=x(gvar.num_y);
% axes(handles.Axes_GraphAxes);
% ezplot(gvar.format_in);
Orig_function();
first_derivative();
second_derivative();
relMinMax();
POI();
% xlim([gvar.domainLower gvar.domainUpper]);
% ylim([gvar.rangeLower gvar.rangeUpper]);
axis([gvar.domainLower gvar.domainUpper gvar.rangeLower gvar.rangeUpper]);
plot([gvar.domainLower gvar.domainUpper],[0 0],'k');
hold on
plot([0 0],[gvar.rangeLower gvar.rangeUpper],'k');
hold on
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);






% Hints: get(hObject,'String') returns contents of Equation_TypeBar as text
%        str2double(get(hObject,'String')) returns contents of Equation_TypeBar as a double


% --- Executes during object creation, after setting all properties.
function Equation_TypeBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Equation_TypeBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global gvar



function domainLower_Callback(hObject, eventdata, handles)
% hObject    handle to domainLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.domainLower=str2num(get(handles.domainLower,'string'));
set(handles.Axes_GraphAxes,'XLim',[gvar.domainLower gvar.domainUpper]);

% Hints: get(hObject,'String') returns contents of domainLower as text
%        str2double(get(hObject,'String')) returns contents of domainLower as a double


% --- Executes during object creation, after setting all properties.
function domainLower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to domainLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rangeLower_Callback(hObject, eventdata, handles)
% hObject    handle to rangeLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.rangeLower=str2num(get(handles.rangeLower,'string'));
set(handles.Axes_GraphAxes,'YLim',[gvar.rangeLower gvar.rangeUpper]);

% Hints: get(hObject,'String') returns contents of rangeLower as text
%        str2double(get(hObject,'String')) returns contents of rangeLower as a double


% --- Executes during object creation, after setting all properties.
function rangeLower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rangeLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in deriv1_CheckBox.
function deriv1_CheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to deriv1_CheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
value1=get(handles.deriv1_CheckBox,'Value');
delete(gvar.graph(2));
if value1==1
gvar.graph(2)=plot(gvar.real_orig_x(:,1:length(gvar.real_first)-1),gvar.real_first(:,1:length(gvar.real_first)-1),'g');
%% Holes f'(x)
for hole_first=2:length(gvar.true_deriv1)-1
    if isnan(gvar.true_deriv1(:,hole_first)) && ~isnan(gvar.true_deriv1...
            (:,hole_first-1)) && ~isnan(gvar.true_deriv1(:,hole_first +1))
        gvar.true_deriv1(:,hole_first)=gvar.true_deriv1(:,hole_first-1);
        hold on
        gvar.graph(2)=scatter(gvar.real_orig_x(:,hole_first),gvar.true_deriv1(:,hole_first),'o','g');
    end
end
hold on

end



% Hint: get(hObject,'Value') returns toggle state of deriv1_CheckBox


% --- Executes on button press in deriv2_CheckBox.
function deriv2_CheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to deriv2_CheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
value2=get(handles.deriv2_CheckBox,'Value');
    delete(gvar.graph(3));
if value2==1
gvar.graph(3)=plot(gvar.real_orig_x(1,1:length(gvar.real_sec)-1),gvar.real_sec(1,1:length(gvar.real_sec)-1),'m');
for hole_second=2:length(gvar.true_deriv2)-2
    if isnan(gvar.true_deriv2(:,hole_second)) && ~isnan(gvar.true_deriv2...
            (:,hole_second-1)) && ~isnan(gvar.true_deriv2(:,hole_second+1))
        gvar.true_deriv2(:,hole_second)=gvar.true_deriv2(:,hole_second-1);
        gvar.graph(3)=scatter(real_orig_x(:,hole_second),gvar.true_deriv2(:,hole_second),'o','m');
    end
end
end
%% Holes for f''(x)



% Hint: get(hObject,'Value') returns toggle state of deriv2_CheckBox



function FTC_LowBound_TextBox_Callback(hObject, eventdata, handles)
% hObject    handle to FTC_LowBound_TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.low_bound=str2num(get(handles.FTC_LowBound_TextBox,'string'));

% Hints: get(hObject,'String') returns contents of FTC_LowBound_TextBox as text
%        str2double(get(hObject,'String')) returns contents of FTC_LowBound_TextBox as a double


% --- Executes during object creation, after setting all properties.
function FTC_LowBound_TextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FTC_LowBound_TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FTC_UpBound_TextBox_Callback(hObject, eventdata, handles)
% hObject    handle to FTC_UpBound_TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
gvar.up_bound=str2num(get(handles.FTC_UpBound_TextBox,'string'));
FTC();
set(handles.areaUnder_Toggle,'Value',1);
set(handles.ftcProof_Toggle,'Value',1);
set(handles.areaUnder_Toggle,'String',gvar.final_value);
set(handles.ftcProof_Toggle,'String',gvar.orig_area);
% set(handles.areaUnderDeriv1,'string',gvar.final_value);
% set(handles.ftcProof,'string',gvar.orig_area);

% Hints: get(hObject,'String') returns contents of FTC_UpBound_TextBox as text
%        str2double(get(hObject,'String')) returns contents of FTC_UpBound_TextBox as a double


% --- Executes during object creation, after setting all properties.
function FTC_UpBound_TextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FTC_UpBound_TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% Hints: get(hObject,'String') returns contents of areaUnderDeriv1 as text
%        str2double(get(hObject,'String')) returns contents of areaUnderDeriv1 as a double





% Hint: get(hObject,'Value') returns toggle state of relMinMax_CheckBox


% --- Executes on button press in POI_CheckBox.


% Hint: get(hObject,'Value') returns toggle state of POI_CheckBox



% Hint: get(hObject,'Value') returns toggle state of holes_CheckBox



% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in areaUnder_Toggle.
function areaUnder_Toggle_Callback(hObject, eventdata, handles)
% hObject    handle to areaUnder_Toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
set(handles.areaUnder_Toggle,'String',gvar.final_value);

% Hint: get(hObject,'Value') returns toggle state of areaUnder_Toggle


% --- Executes on button press in ftcProof_Toggle.
function ftcProof_Toggle_Callback(hObject, eventdata, handles)
% hObject    handle to ftcProof_Toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
set(handles.ftcProof_Toggle,'String',gvar.orig_area);
% Hint: get(hObject,'Value') returns toggle state of ftcProof_Toggle
