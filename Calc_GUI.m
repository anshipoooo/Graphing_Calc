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

% Last Modified by GUIDE v2.5 18-Dec-2017 15:30:22

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
plot(gvar.aH,gvar.real_orig_x,gvar.real_first,'g');


% --- Executes on button press in Deriv2_PushButton.
function Deriv2_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to Deriv2_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar
plot(gvar.aH,gvar.real_orig_x,gvar.real_sec,'m');


% --- Executes on button press in FTC_PushButton.
function FTC_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to FTC_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar



function Domain_TypeBar_Callback(hObject, eventdata, handles)
% hObject    handle to Domain_TypeBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar

% Hints: get(hObject,'String') returns contents of Domain_TypeBar as text
%        str2double(get(hObject,'String')) returns contents of Domain_TypeBar as a double


% --- Executes during object creation, after setting all properties.
function Domain_TypeBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Domain_TypeBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
   
end
global gvar



function Range_TypeBar_Callback(hObject, eventdata, handles)
% hObject    handle to Range_TypeBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gvar

% Hints: get(hObject,'String') returns contents of Range_TypeBar as text
%        str2double(get(hObject,'String')) returns contents of Range_TypeBar as a double


% --- Executes during object creation, after setting all properties.
function Range_TypeBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Range_TypeBar (see GCBO)
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
equation=get(handles.Equation_TypeBar,'string');
whos equation
equation_true=char(equation);
whos equation_true
axes(handles.Axes_GraphAxes);
ezplot(equation_true);


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
