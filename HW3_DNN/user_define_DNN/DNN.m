function varargout = DNN(varargin)
% DNN MATLAB code for DNN.fig
%      DNN, by itself, creates a new DNN or raises the existing
%      singleton*.
%
%      H = DNN returns the handle to a new DNN or the handle to
%      the existing singleton*.
%
%      DNN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DNN.M with the given input arguments.
%
%      DNN('Property','Value',...) creates a new DNN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DNN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DNN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DNN

% Last Modified by GUIDE v2.5 29-Jun-2020 01:01:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DNN_OpeningFcn, ...
                   'gui_OutputFcn',  @DNN_OutputFcn, ...
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


% --- Executes just before DNN is made visible.
function DNN_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DNN (see VARARGIN)

% Choose default command line output for DNN
handles.output = hObject; 
handles.target = zeros(28,28);
handles.output_text = [];
% handles.result_out = 0;
handles.work_mode = 0;
% han_re = load('tanh_7_2.mat');
han_im = load('Train_images.mat');
% handles.Weights = han_re.Weights;
% handles.Biases = han_re.Biases;
handles.images = han_im.images;
handles.draw_enable = 0;
handles.x = [];
handles.y = [];
set(handles.axes1,'visible','off');
ha = axes('units','normalized','pos',[0 0 1 1]);
uistack(ha,'down');
back = imread('AI.jpg');
image(back);
%colormap gray
set(ha,'handlevisibility','off','visible','on');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DNN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DNN_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, ~, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.checkbox1,'value',1);
set(handles.checkbox2,'value',0);
handles.work_mode = 1;
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in load.
function load_Callback(hObject, ~, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        if handles.work_mode
            [~,~,M] = size(handles.images);
            n = randi([1,M],1,1);
            handles.target = handles.images(:,:,n);  
            %display(handles.target);
            image(handles.axes1,round(handles.target.*255));
        end
guidata(hObject, handles);

% --- Executes on button press in identify.
function identify_Callback(~, eventdata, handles)
% hObject    handle to identify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_ope = zeros(784,1);
for i = 1:28
    x_ope((i-1)*28+1:i*28,1) = handles.target(:,i);
end
% x_ope = zscore(x_ope);
% display(handles.target);
handles.output_text = myNeuralNetworkFunction_round2(x_ope);
set(handles.text2,'String',num2str(handles.output_text),...
                'FontSize',12);
 [~,I] = max(handles.output_text);
set(handles.result_out,'String',num2str(I-1));
% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, ~, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.checkbox1,'value',0);
set(handles.checkbox2,'value',1);
handles.work_mode = 0;
cla reset
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.draw_enable
    position=get(gca,'currentpoint');
    handles.x(2)=position(1);
    handles.y(2)=position(3);
    %line(handles.x,handles.y,'LineWidth',20,'color','b');%,'EraseMode','xor'
    animatedline(handles.x,handles.y,'LineWidth',15,'color','b');
    handles.x(1)=handles.x(2);
    handles.y(1)=handles.y(2);
end
guidata(hObject, handles);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'XLim',[0,1],'YLim',[0,1]);
handles.draw_enable=1;
if handles.draw_enable
    position=get(gca,'currentpoint');
    handles.x(1)=position(1);
    handles.y(1)=position(3);
end
guidata(hObject, handles);


% --- Executes on button press in comp.
function comp_Callback(hObject, eventdata, handles)
% hObject    handle to comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.draw_enable=0;
h=getframe(handles.axes1);
out = imresize(h.cdata,[28 28]);
handles.target = 1-double(out./255.0);
% display(handles.target);
imwrite(out,'output.bmp','bmp');
% cla(handles.axes1);
guidata(hObject, handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.draw_enable=0;
guidata(hObject, handles);
