function varargout = EditorApp(varargin)
% EDITORAPP MATLAB code for EditorApp.fig
%      EDITORAPP, by itself, creates a new EDITORAPP or raises the existing
%      singleton*.
%
%      H = EDITORAPP returns the handle to a new EDITORAPP or the handle to
%      the existing singleton*.
%
%      EDITORAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITORAPP.M with the given input arguments.
%
%      EDITORAPP('Property','Value',...) creates a new EDITORAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EditorApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EditorApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EditorApp

% Last Modified by GUIDE v2.5 26-Nov-2016 00:07:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EditorApp_OpeningFcn, ...
                   'gui_OutputFcn',  @EditorApp_OutputFcn, ...
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


% --- Executes just before EditorApp is made visible.
function EditorApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EditorApp (see VARARGIN)
handles.model = load('01_MorphableModel.mat');
handles.currentShape=handles.model.shapeMU;
handles.currentTexture=handles.model.texMU;
handles.rp     = defrp;
handles.rp.phi = 0.5;
handles.rp.dir_light.dir = [0;1;1];
handles.rp.dir_light.intens = 0.6*ones(3,1);
display_face(handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
handles.attrib = load('04_attributes.mat');
handles.state.s2=0;
handles.state.s3=0;
handles.state.s4=0;
handles.state.s5=0;
handles.state.s6=0;
handles.state.s7=0;
handles.state.s8=0;
handles.state.s9=0;
handles.state.s10=0;
handles.state.s11=0;
handles.state.s12=0;
handles.state.s13=0;


% Choose default command line output for EditorApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EditorApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EditorApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s2;
handles.state.s2=sliderValue;
handles.currentShape=handles.currentShape+x*handles.model.shapeEV(2)*handles.model.shapePC(:,2);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s3;
handles.state.s3=sliderValue;
handles.currentShape=handles.currentShape+x*handles.model.shapeEV(3)*handles.model.shapePC(:,3);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s4;
handles.state.s4=sliderValue;
handles.currentShape=handles.currentShape+x*handles.model.shapeEV(4)*handles.model.shapePC(:,4);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s5;
handles.state.s5=sliderValue;
handles.currentTexture=handles.currentTexture+x*handles.model.texEV(1)*handles.model.texPC(:,1);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s6;
handles.state.s6=sliderValue;
handles.currentTexture=handles.currentTexture+x*handles.model.texEV(2)*handles.model.texPC(:,2);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s7;
handles.state.s7=sliderValue;
handles.currentTexture=handles.currentTexture+x*handles.model.texEV(3)*handles.model.texPC(:,3);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s8;
handles.state.s8=sliderValue;
handles.currentTexture=handles.currentTexture+x*handles.model.texEV(4)*handles.model.texPC(:,4);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s9;
handles.state.s9=sliderValue;
handles.currentTexture=handles.currentTexture+handles.model.texPC*(x*handles.attrib.age_tex(1:199,:).*handles.model.texEV);
handles.currentShape=handles.currentShape+handles.model.shapePC*(x*handles.attrib.age_shape(1:199,:).*handles.model.shapeEV);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s10;
handles.state.s10=sliderValue;
handles.currentTexture=handles.currentTexture+handles.model.texPC*(x*handles.attrib.gender_tex(1:199,:).*handles.model.texEV);
handles.currentShape=handles.currentShape+handles.model.shapePC*(x*handles.attrib.gender_shape(1:199,:).*handles.model.shapeEV);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s11;
handles.state.s11=sliderValue;
handles.currentTexture=handles.currentTexture+handles.model.texPC*(x*handles.attrib.height_tex(1:199,:).*handles.model.texEV);
handles.currentShape=handles.currentShape+handles.model.shapePC*(x*handles.attrib.height_shape(1:199,:).*handles.model.shapeEV);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s12;
handles.state.s12=sliderValue;
handles.currentTexture=handles.currentTexture+handles.model.texPC*(x*handles.attrib.weight_tex(1:199,:).*handles.model.texEV);
handles.currentShape=handles.currentShape+handles.model.shapePC*(x*handles.attrib.weight_shape(1:199,:).*handles.model.shapeEV);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = single(get(hObject, 'Value'));
x=sliderValue-handles.state.s13;
handles.state.s13=sliderValue;
handles.currentShape=handles.currentShape+x*handles.model.shapeEV(1)*handles.model.shapePC(:,1);
update_face(gcf,handles.currentShape,handles.currentTexture,handles.model.tl,handles.rp);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
