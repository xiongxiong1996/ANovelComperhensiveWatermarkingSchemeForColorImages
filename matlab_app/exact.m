function varargout = exact(varargin)
% EXACT MATLAB code for exact.fig
%      EXACT, by itself, creates a new EXACT or raises the existing
%      singleton*.
%
%      H = EXACT returns the handle to a new EXACT or the handle to
%      the existing singleton*.
%
%      EXACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXACT.M with the given input arguments.
%
%      EXACT('Property','Value',...) creates a new EXACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exact_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exact_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exact

% Last Modified by GUIDE v2.5 23-Dec-2020 15:54:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exact_OpeningFcn, ...
                   'gui_OutputFcn',  @exact_OutputFcn, ...
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


% --- Executes just before exact is made visible.
function exact_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exact (see VARARGIN)

% Choose default command line output for exact
handles.output = hObject;

handles.flag_ai=0; % 设定参数flag_ai，来判断是否已经读入了attacked Img
handles.flag_tmi=0; % 设定参数flag_ai，来判断是否已经生成了篡改检测图

guidata(hObject,handles); % Update handles structure

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exact wait for user response (see UIRESUME)
% uiwait(handles.figure_exact);


% --- Outputs from this function are returned to the command line.
function varargout = exact_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
    {'*.bmp;*.jpg;*.png;*.jpeg','(*.bmp,*.jpg,*.png,*,jpeg)';...
    '*,*','(*.*)'}, ...
    '');
if isequal(filename,0)||isequal(pathname,0)
    return;
end

axes(handles.axes1);
attacked_img=[pathname filename];
img_src=imread(attacked_img);
handles.attacked_img=img_src;
guidata(hObject,handles);
handles.flag_ai=1; % 设定参数flag_ai，来判断是否已经读入了attacked Img
guidata(hObject,handles); % Update handles structure
imshow(img_src);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wname=handles.wname; % 更改flage
lambda=handles.lambda; % 更改flage
dt=handles.dt; % 更改flage
n=handles.n; % 更改flage
a=handles.a; % 更改flage
b=handles.b; % 更改flage

question=['wname:' wname 10 'lambda:' num2str(lambda) 10 'dt:' num2str(dt) 10 'n:' num2str(n) 10 'a:' num2str(a) 10 'b:' num2str(b) 10 'Are you sure to embed?']

choice = questdlg(question,'Dessert Menu','Yes','No','No');
% Handle response
switch choice
    case 'No'
			return
    case 'Yes'

flag_ai=handles.flag_ai;
if handles.flag_ai==0
	box = msgbox('no image to be detected''error','error');
else
tic;                                % tic;?toc;

set(handles.pushbutton1,'enable','off');
set(handles.pushbutton2,'enable','off');
set(handles.pushbutton5,'enable','off');
set(handles.pushbutton6,'enable','off');
set(handles.pushbutton7,'enable','off');

bar = waitbar(0,'embedding');    % waitbar
str=['extract w1'];
waitbar(0.1,bar,str);
set(bar,'closerequestfcn','');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%参数设定%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambda = handles.lambda;
dt = handles.dt;
n = handles.n;
a = handles.a;
b = handles.b;
wname = handles.wname;





attacked_img=handles.attacked_img;
extract_w1=dsh_extract2(attacked_img(:,:,1),1,8,wname,32,n,a,b); 

str=['extract w2'];
waitbar(0.4,bar,str);
extract_w2=dsh_extract3(attacked_img(:,:,2),1,4,wname,dt,32,n,a,b); 
axes(handles.axes2);
imshow(extract_w1);

axes(handles.axes3);
imshow(extract_w2);

str=['Generate tamper detection map'];
waitbar(0.7,bar,str);
taggedImg = dsh_extractFragileW(attacked_img,16);
axes(handles.axes4);
imshow(taggedImg);
handles.flag_tmi=1; % 篡改检测图已经生成
handles.taggedImg = taggedImg;
guidata(hObject,handles); % Update handles structure
str=['exact end'];
waitbar(1.0,bar,str);
pause(0.5);

set(bar, 'CloseRequestFcn', ['delete(gcf);']);
close(bar)  
set(handles.pushbutton1,'enable','on');
set(handles.pushbutton2,'enable','on');
set(handles.pushbutton5,'enable','on');
set(handles.pushbutton6,'enable','on');
set(handles.pushbutton7,'enable','on');

toc;      
end
end
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% Hint: place code in OpeningFcn to populate axes3

function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% Hint: place code in OpeningFcn to populate axes4



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.lambda=15; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.lambda);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.dt=72; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.dt);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.n=10; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.n);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.a=3; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.a);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.b=5; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.b);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.wname='db2'; % 更改flage
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.wname);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.lambda = str2num(get(handles.edit13,'string'));
handles.dt = str2num(get(handles.edit14,'string'));
handles.n = str2num(get(handles.edit15,'string'));
handles.a = str2num(get(handles.edit16,'string'));
handles.b = str2num(get(handles.edit17,'string'));
handles.wname = get(handles.edit18,'string');
guidata(hObject,handles); % Update handles structure


set(handles.edit13,'string',handles.lambda);
set(handles.edit14,'string',handles.dt);
set(handles.edit15,'string',handles.n);
set(handles.edit16,'string',handles.a);
set(handles.edit17,'string',handles.b);
set(handles.edit18,'string',handles.wname);
box=msgbox('submitted','msg','help'); % 没有生成提示


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.lambda = 15;
handles.dt = 72;
handles.n = 10;
handles.a = 3;
handles.b = 5;
handles.wname = 'db2';
guidata(hObject,handles); % Update handles structure

set(handles.edit13,'string',handles.lambda);
set(handles.edit14,'string',handles.dt);
set(handles.edit15,'string',handles.n);
set(handles.edit16,'string',handles.a);
set(handles.edit17,'string',handles.b);
set(handles.edit18,'string',handles.wname);
box=msgbox('submitted','msg','help'); % 没有生成提示


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flag_tmi=handles.flag_tmi;
if flag_tmi==0
	box=msgbox('no tagged image','error','error'); % 没有生成提示
else
% 按钮变为不可用
set(handles.pushbutton1,'enable','off');
set(handles.pushbutton2,'enable','off');
% set(handles.pushbutton3,'enable','off');
% set(handles.pushbutton4,'enable','off');



taggedImg = handles.taggedImg; % 读取篡改检测图
T = clock;
time = [num2str(T(1)) num2str(T(2)) num2str(T(3)) num2str(T(4)) num2str(T(5)) num2str(uint8(T(6)))];
pathname = uigetdir('C:\');
filename=['\taggedImg' time '.png'];
if isequal(filename,0)||isequal(pathname,0)
    return;
end
path = [pathname filename];
imwrite(taggedImg,path) % 写入到本地目录
box = msgbox('Saved successfully!','msg','help'); % 提示存储成功
waitfor(box); % 等提示窗关闭
close(gcbf); % 关闭窗口
end