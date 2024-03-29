function varargout = embed(varargin)
% EMBED MATLAB code for embed.fig
%      EMBED, by itself, creates a new EMBED or raises the existing
%      singleton*.
%
%      H = EMBED returns the handle to a new EMBED or the handle to
%      the existing singleton*.
%
%      EMBED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMBED.M with the given input arguments.
%
%      EMBED('Property','Value',...) creates a new EMBED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before embed_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to embed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help embed

% Last Modified by GUIDE v2.5 23-Dec-2020 15:54:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @embed_OpeningFcn, ...
                   'gui_OutputFcn',  @embed_OutputFcn, ...
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


% --- Executes just before embed is made visible.
function embed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to embed (see VARARGIN)

% Choose default command line output for embed
handles.output = hObject;

% Ybutton=imread('1.png');   % buttonͼƬ
% set(handles.pushbutton3,'CData',Ybutton);  % buttonͼƬ
% set(handles.pushbutton4,'CData',Ybutton);  % buttonͼƬ
% Bbutton=imread('4.png');   % buttonͼƬ
% set(handles.pushbutton1,'CData',Bbutton);  % buttonͼƬ
% set(handles.pushbutton2,'CData',Bbutton);  % buttonͼƬ
% global flag_hi;
% flag_hi=0;
% global flag_wi;
% flag_wi=0;
handles.flag_hi=0; % ��� �鿴�Ƿ������host Img
guidata(hObject,handles); % Update handles structure
handles.flag_wi=0; % ��� �鿴�Ƿ������ˮӡͼ��WImg
guidata(hObject,handles); % Update handles structure
handles.flag_wdi=0;% ��� �鿴�Ƿ�������atermarked Img
guidata(hObject,handles); % Update handles structure


% UIWAIT makes embed wait for user response (see UIRESUME)
% uiwait(handles.figure_embed);


% --- Outputs from this function are returned to the command line.
function varargout = embed_OutputFcn(hObject, eventdata, handles) 
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
    ''); % �ļ��б�ѡ������ͼ��
if isequal(filename,0)||isequal(pathname,0)
    return;
end

axes(handles.axes1); % ѡ����ʾͼ���axes
wImg=[pathname filename]; % ˮӡͼ��·��
img_src=imread(wImg); % ����ˮӡͼ��
handles.wImg=img_src; % ˮӡͼ��洢��handles�� % Update handles structure
handles.flag_wi=1; % ˮӡͼ��ȡ��Ǳ�Ϊ1
guidata(hObject,handles); % Update handles structure
imshow(img_src); % չʾˮӡͼ��


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
    {'*.bmp;*.jpg;*.png;*.jpeg;*.tiff','(*.bmp,*.jpg,*.png,*.jpeg,*.tiff)';...
    '*,*','(*.*)'}, ...
    ''); % ��ͼƬ�ٖ�
if isequal(filename,0)||isequal(pathname,0)
    return;
end

axes(handles.axes2);% ѡ����ʾͼ���axes
hostImage=[pathname filename]; % ����ͼ��·��
img_src=imread(hostImage); % ��ȡ����ͼ��
handles.hostImage=img_src; % ������ͼ��洢��handles
handles.flag_hi=1;% ��������ͼ����
guidata(hObject,handles); % Update handles structure
imshow(img_src); % չʾ����ͼ��


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

wname=handles.wname; % ȡ����
lambda=handles.lambda; % ȡ����
dt=handles.dt; % ȡ����
n=handles.n; % ȡ����
a=handles.a; % ȡ����
b=handles.b; % ȡ����

question=['wname:' wname 10 'lambda:' num2str(lambda) 10 'dt:' num2str(dt) 10 'n:' num2str(dt) 10 'a:' num2str(dt) 10 'b:' num2str(b) 10 'Are you sure to embed?']

choice = questdlg(question,'Dessert Menu','Yes','No','No');
% Handle response
switch choice
    case 'No'
			return
    case 'Yes'

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flag_wi = handles.flag_wi; % ȡˮӡͼ����
flag_hi = handles.flag_hi; % ȡ����ͼ����
% ���ݱ�Ƿ��ز�ͬ�Ľ��
if flag_wi==0 || flag_hi ==0
	if flag_wi==0 && flag_hi ==0
		box = msgbox('no watermark image and host image','error','error');

	else 
		if flag_wi==1 && flag_hi ==0
			box = msgbox('no host image''error','error');
		else
			box = msgbox('no watermark image''error','error');
		end
	end
else
	
tic;                                % tic ��ʼ

% ��ť����
set(handles.pushbutton1,'enable','off');
set(handles.pushbutton2,'enable','off');
set(handles.pushbutton3,'enable','off');
set(handles.pushbutton4,'enable','off');
set(handles.pushbutton5,'enable','off');
set(handles.pushbutton7,'enable','off');
% չʾ������
bar = waitbar(0,'embedding');    % waitbar
set(bar,'closerequestfcn','');
str=['read Image'];
waitbar(0.1,bar,str);




hostImage=handles.hostImage;
wImg=handles.wImg;
watermarkedImg = hostImage;

ht1=hostImage(:,:,1); % R
ht2=hostImage(:,:,2); % G
ht3=hostImage(:,:,3); % B

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%       ˮӡǶ��   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=1; % shearlet �仯����
block_size1=8; % 
block_size2=4; % 
block_size3=16; % 
img_border=5; % 




% bar
str=['embeding w1'];
waitbar(0.3,bar,str);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%    Ƕ��³��ˮӡw1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1 = dsh_embed2(ht1,wImg,s1,block_size1,lambda,wname,n,a,b); % Ƕ��³��ˮӡw1
watermarkedImg(:,:,1) = w1; % Ƕ����滻

% bar
str=['embeding w2'];
waitbar(0.5,bar,str);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%   Ƕ��³��ˮӡw2 %%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w2 = dsh_embed3(ht2,wImg,s1,block_size2,dt,wname); %   Ƕ��³��ˮӡw2 
watermarkedImg(:,:,2) = w2; % Ƕ����滻s

% bar
str=['embeding w3'];
waitbar(0.7,bar,str);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%    Ƕ�����ˮӡw3 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

watermarkedImg = dsh_embedFragileW(watermarkedImg,block_size3); % Ƕ�����ˮӡw3 

% bar
str=['embeding end'];
waitbar(1.0,bar,str);
% pause
pause(0.5);

% չʾ��ˮӡͼ��
axes(handles.axes3);
imshow(watermarkedImg);

set(bar, 'CloseRequestFcn', ['delete(gcf);']);
close(bar)                % �ر�bar

handles.watermarkedImg=watermarkedImg; % ��ˮӡͼ��洢��handles
guidata(hObject,handles); % Update handles structure
handles.flag_wdi=1; % ���ĺ�ˮӡͼ����
guidata(hObject,handles);% Update handles structure
set(handles.pushbutton1,'enable','on');
set(handles.pushbutton2,'enable','on');
set(handles.pushbutton3,'enable','on');
set(handles.pushbutton4,'enable','on');
set(handles.pushbutton5,'enable','on');
set(handles.pushbutton7,'enable','on');
toc;                       % toc ����
end % if
end % switch


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ����watermarked Image 
flag_wdi=handles.flag_wdi;
if flag_wdi==0
	box=msgbox('no watermarked Image','error','error'); % ûwatermarked Image 
else
watermarkedImg=handles.watermarkedImg; % ȡwatermarkedImg
T = clock;
time = [num2str(T(1)) num2str(T(2)) num2str(T(3)) num2str(T(4)) num2str(T(5)) num2str(uint8(T(6)))];
pathname = uigetdir('C:\');
filename=['\watermarkedImg' time '.png'];
if isequal(filename,0)||isequal(pathname,0)
    return;
end
path = [pathname filename];
imwrite(watermarkedImg,path) % ��watermarkedImg����
box = msgbox('Saved successfully!','msg','help'); % ����ɹ���ʾ
waitfor(box); 
close(gcbf); 
close(gcbf); 
embed;
end
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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

handles.lambda=15; % Ƕ��ǿ��1
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.lambda);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.dt=72; % Ƕ��ǿ��2
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.dt);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.n=10; % ���Ҳ���1
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.n);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.a=3; % ���Ҳ���2
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.a);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.b=5; % ���Ҳ���3
guidata(hObject,handles); % Update handles structure
set(hObject,'string',handles.b);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.wname='db2'; % С������
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

handles.lambda = str2num(get(handles.edit1,'string'));
handles.dt = str2num(get(handles.edit3,'string'));
handles.n = str2num(get(handles.edit4,'string'));
handles.a = str2num(get(handles.edit5,'string'));
handles.b = str2num(get(handles.edit6,'string'));
handles.wname = get(handles.edit7,'string');
guidata(hObject,handles); % Update handles structure


set(handles.edit1,'string',handles.lambda);
set(handles.edit3,'string',handles.dt);
set(handles.edit4,'string',handles.n);
set(handles.edit5,'string',handles.a);
set(handles.edit6,'string',handles.b);
set(handles.edit7,'string',handles.wname);
box=msgbox('submitted','msg','help'); % �ύ�ɹ�


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.lambda = 15;
handles.dt = 72;
handles.n = 10;
handles.a = 3;
handles.b = 5;
handles.wname = 'db2';
guidata(hObject,handles); % Update handles structure

set(handles.edit1,'string',handles.lambda);
set(handles.edit3,'string',handles.dt);
set(handles.edit4,'string',handles.n);
set(handles.edit5,'string',handles.a);
set(handles.edit6,'string',handles.b);
set(handles.edit7,'string',handles.wname);
box=msgbox('submitted','msg','help'); % �ύ�ɹ�
