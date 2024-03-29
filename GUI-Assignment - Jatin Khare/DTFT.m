function varargout = DTFT(varargin)
% DTFT MATLAB code for DTFT.fig
%      DTFT, by itself, creates a new DTFT or raises the existing
%      singleton*.
%
%      H = DTFT returns the handle to a new DTFT or the handle to
%      the existing singleton*.
%
%      DTFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DTFT.M with the given input arguments.
%
%      DTFT('Property','Value',...) creates a new DTFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DTFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DTFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DTFT

% Last Modified by GUIDE v2.5 28-Oct-2018 23:46:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DTFT_OpeningFcn, ...
                   'gui_OutputFcn',  @DTFT_OutputFcn, ...
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


% --- Executes just before DTFT is made visible.
function DTFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DTFT (see VARARGIN)

% Choose default command line output for DTFT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DTFT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DTFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs = 1000;
recObj = audiorecorder(Fs,8,1);
recordblocking(recObj,1);
x = getaudiodata(recObj);
audiowrite('GUIInput.wav',x,Fs);
%x = audioread('signal.wav');
W = jatinkhare_Dftmatrix(length(x));
y = (W*x);
N = length(x);
axes(handles.axes1);
plot(x);
axis tight; hold on;
title('Time Domain Input')
axes(handles.axes2);
plot(abs(y),'k');
xlim([700 1000])


[m,loc] = max(y);
y(loc-10:loc+10)=0;
[m,loc] = max(y);
y(loc-10:loc+10)=0;
axes(handles.axes3);
plot(abs(y),'k');
xlim([700 1000])
idft = real(conj(W)*y)/length(x);
axes(handles.axes4);
plot(idft);

audiowrite('GUIOut.wav',idft,Fs);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%g = audioplayer('GUIInput',1000);
[y,fs] = audioread('GUIInput.wav');
soundsc(y,fs);




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y,fs] = audioread('GUIOut.wav');
soundsc(y,fs);
