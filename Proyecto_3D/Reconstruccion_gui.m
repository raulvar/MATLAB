function varargout = Reconstruccion_gui(varargin)
% RECONSTRUCCION_GUI MATLAB code for Reconstruccion_gui.fig
%      RECONSTRUCCION_GUI, by itself, creates a new RECONSTRUCCION_GUI or raises the existing
%      singleton*.
%
%      H = RECONSTRUCCION_GUI returns the handle to a new RECONSTRUCCION_GUI or the handle to
%      the existing singleton*.
%
%      RECONSTRUCCION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECONSTRUCCION_GUI.M with the given input arguments.
%
%      RECONSTRUCCION_GUI('Property','Value',...) creates a new RECONSTRUCCION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Reconstruccion_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Reconstruccion_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Reconstruccion_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Reconstruccion_gui_OutputFcn, ...
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


% --- Executes just before Reconstruccion_gui is made visible.
function Reconstruccion_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Reconstruccion_gui (see VARARGIN)
% Choose default command line output for Reconstruccion_gui
axes(handles.axes3)
imshow('Logo.png')
handles.output = hObject;
handles.C1=0;
handles.C2=0;
handles.C3=0;
handles.C4=0;
handles.pla=0;
handles.ima=0;
handles.n=4;
handles.bandera=0;
handles.I1 = 0;
handles.I2 = 0;
handles.I3 = 0;
handles.I4 = 0;
handles.P1 = 0;
handles.P2 = 0;
handles.P3 = 0;
handles.P4 = 0;
handles.T=220;
handles.T2=90;
handles.nn=9;
handles.p=6;
handles.met=0;
handles.direccion =0;
handles.nombre=0;
handles.fil=9;
handles.z=0;
% Update handles structure
guidata(hObject, handles);
function varargout = Reconstruccion_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in metodo.
function metodo_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
handles.metodo = get(hObject,'Value');
guidata(hObject, handles); 

function metodo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function I1_Callback(hObject, eventdata, handles)
handles.I1= imread(get(hObject,'String'));
guidata(hObject, handles); 
function I1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function I2_Callback(hObject, eventdata, handles)
handles.I2= imread(get(hObject,'String'));
guidata(hObject, handles);
function I2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function I3_Callback(hObject, eventdata, handles)
handles.I3= imread(get(hObject,'String'));
guidata(hObject, handles);

function I3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function I4_Callback(hObject, eventdata, handles)
handles.I4= imread(get(hObject,'String'));
guidata(hObject, handles);
function I4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function C1_Callback(hObject, eventdata, handles)
handles.C1 = get(hObject,'Value');
if handles.C1==1 && ~isvector(handles.I1) && ~isvector(handles.P1)
if (handles.C2+handles.C3+handles.C4 ==0)
handles.ima=handles.I1;
handles.pla=handles.P1;
axes(handles.peque)
imshowpair(handles.ima,handles.pla,'montage')
else
    errordlg('Por favor seleccione solo uno','Warning');
end
elseif (handles.C2+handles.C3+handles.C4 > 1)
    errordlg('Por favor seleccione solo uno','Warning');
elseif isvector(handles.I1) || isvector(handles.P1)
     errordlg('Por favor asegurese de haber ingresado la dirección de I1 y P1' ...
               ,'No ha cargado imagenes');
end
guidata(hObject, handles);
function C2_Callback(hObject, eventdata, handles)
handles.C2 = get(hObject,'Value');
if handles.C2==1 && ~isvector(handles.I2) && ~isvector(handles.P2)
if (handles.C1+handles.C3+handles.C4 ==0)
handles.ima=handles.I2;
handles.pla=handles.P2;
axes(handles.peque)
imshowpair(handles.ima,handles.pla,'montage')
else
    errordlg('Por favor seleccione solo uno','Warning');
end
elseif (handles.C4+handles.C3+handles.C1 > 1)
    errordlg('Por favor seleccione solo uno','Warning');
elseif isvector(handles.I2) || isvector(handles.P2)
     errordlg('Por favor asegurese de haber ingresado la dirección de I2 y P2' ...
               ,'No ha cargado imagenes');
end
guidata(hObject, handles);

function C3_Callback(hObject, eventdata, handles)
handles.C3 = get(hObject,'Value');
if handles.C3==1 && ~isvector(handles.I3) && ~isvector(handles.P3)
if (handles.C2+handles.C1+handles.C4 ==0 && handles.C3==1)
handles.ima=handles.I3;
handles.pla=handles.P3;
axes(handles.peque)
imshowpair(handles.ima,handles.pla,'montage')
else
    errordlg('Por favor seleccione solo uno','Warning');
end
elseif (handles.C2+handles.C4+handles.C1 > 1)
    errordlg('Por favor seleccione solo uno','Warning');
elseif isvector(handles.I3) || isvector(handles.P3)
     errordlg('Por favor asegurese de haber ingresado la dirección de I3 y P3' ...
               ,'No ha cargado imagenes');
end
guidata(hObject, handles);
function C4_Callback(hObject, eventdata, handles)
handles.C4 = get(hObject,'Value');
if  handles.C4==1 && ~isvector(handles.I4) && ~isvector(handles.P4)
if (handles.C2+handles.C3+handles.C1 ==0)
handles.ima=handles.I4;
handles.pla=handles.P4;
axes(handles.peque)
imshowpair(handles.ima,handles.pla,'montage')
else
    errordlg('Por favor seleccione solo uno','Warning');
end
elseif (handles.C2+handles.C3+handles.C1 > 1)
    errordlg('Por favor seleccione solo uno','Warning');
elseif isvector(handles.I4) || isvector(handles.P4)
     errordlg('Por favor asegurese de haber ingresado la dirección de I4 y P4' ...
               ,'No ha cargado imagenes');
end
guidata(hObject, handles);
function P1_Callback(hObject, eventdata, handles)
handles.P1= imread(get(hObject,'String'));
guidata(hObject, handles); 
function P1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function P2_Callback(hObject, eventdata, handles)
handles.P2= imread(get(hObject,'String'));
guidata(hObject, handles); 
function P2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function P3_Callback(hObject, eventdata, handles)
handles.P3= imread(get(hObject,'String'));
guidata(hObject, handles); 
function P3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function P4_Callback(hObject, eventdata, handles)
handles.P4= imread(get(hObject,'String'));
guidata(hObject, handles); 
function P4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Go_Callback(hObject, eventdata, handles)
handles.met = handles.metodo; 
if handles.met ~= 0
switch (handles.metodo)
    case 1
        
        if (isvector(handles.pla) || isvector(handles.ima))
            errordlg('Por favor seleccione carge las imagenes y seleccione una' ... 
                      ,'Error al hacer la reconstruccion');
        else
        recons = R3D_TF_pr(handles.pla,handles.ima);
        handles.recons =recons;
        handles.reconsA=recons;
        n=handles.n;
        f=1:n:size(recons,1); c=1:n:size(recons,2);
        axes(handles.grande)
        mesh(c,f,flipud(recons(f,c)));
        end

    case 2
        if (isvector(handles.pla) || isvector(handles.ima))
            errordlg('Por favor seleccione carge las imagenes y seleccione una' ... 
                      ,'Error al hacer la reconstruccion');
        else
         hilb = hilbert2(handles.ima);
        recons = R3D_TF_pr(handles.pla,hilb);
        handles.recons =recons;
        handles.reconsA=recons;
        n=handles.n;
        f=1:n:size(recons,1); c=1:n:size(recons,2);
        axes(handles.grande)
        mesh(c,f,flipud(recons(f,c)));
        end
        
    case 3
         if (isvector(handles.pla) || isvector(handles.ima))
            errordlg('Por favor seleccione carge las imagenes y seleccione una' ... 
                      ,'Error al hacer la reconstruccion');
         else
            hilb = hilbert2(handles.ima);
        recons = R3D_TF_pr(hilbert2(handles.pla),hilb);
        handles.recons =recons;
        handles.reconsA=recons;
        n=handles.n;
        f=1:n:size(recons,1); c=1:n:size(recons,2);
        axes(handles.grande)
        mesh(c,f,flipud(recons(f,c)));
        end
        
    case 4
        if (isvector(handles.pla) || isvector(handles.ima))
            errordlg('Por favor seleccione carge las imagenes y seleccione una' ... 
                      ,'Error al hacer la reconstruccion');
        else
        T=handles.T; nn=handles.nn;p=handles.p;
        handles.m1=Mascara(handles.I1,T,nn,p);
        handles.m2=Mascara(handles.I2,T,nn,p);
        handles.m3=Mascara(handles.I3,T,nn,p);
        handles.m4=Mascara(handles.I4,T,nn,p);
        I5 = (handles.I1+handles.I2+handles.I3+handles.I4)<handles.T2;
        handles.m5=handles.m1.*handles.m2.*handles.m3.*handles.m4.*(~I5);
        axes(handles.peque)
        imshow(255*handles.m5)
        end
        
end
else
    errordlg('Por favor seleccione el metodo que desea emplear' ... 
                      ,'No ha seleccionado metodo');
end

guidata(hObject, handles); 


% 
% --- Executes on button press in Aplicar_mascara.
function Aplicar_mascara_Callback(hObject, eventdata, handles)
recons = handles.recons;
recons = recons.*handles.m5;
handles.recons = recons;
handles.bandera=1;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 

function z_Callback(hObject, eventdata, handles)
handles.z =  str2double(get(hObject,'String'));
guidata(hObject, handles); 
function z_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function mas_Callback(hObject, eventdata, handles)
recons = handles.recons;
if handles.bandera == 0
    recons = recons+handles.z;
else
    recons = (recons+handles.z).*handles.m5;
end
handles.recons = recons;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 

function menos_Callback(hObject, eventdata, handles)
recons = handles.recons;
if handles.bandera == 0
    recons = recons-handles.z;
else
    recons = (recons-handles.z).*handles.m5;
end
handles.recons = recons;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 

function invertir_Callback(hObject, eventdata, handles)
recons = handles.recons;
recons = -recons;
handles.recons = recons;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 

function n_Callback(hObject, eventdata, handles)
handles.n =  str2double(get(hObject,'String'));
guidata(hObject, handles); 
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function uipanel6_DeleteFcn(hObject,eventdata,handles)
%
%


% --- Executes on button press in Restaurar.
function Restaurar_Callback(hObject, eventdata, handles)
recons = handles.reconsA;
handles.recons = handles.reconsA;
handles.recons = recons;
handles.bandera=0;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 



function T_Callback(hObject, eventdata, handles)
% hObject    handle to T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.T=  str2double(get(hObject,'String'));
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nn_Callback(hObject, eventdata, handles)
% hObject    handle to nn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.nn=  str2double(get(hObject,'String'));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of nn as text
%        str2double(get(hObject,'String')) returns contents of nn as a double


% --- Executes during object creation, after setting all properties.
function nn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.p=  str2double(get(hObject,'String'));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of p as text
%        str2double(get(hObject,'String')) returns contents of p as a double


% --- Executes during object creation, after setting all properties.
function p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.T2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double


% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in eliminar.
function eliminar_Callback(hObject, eventdata, handles)
recons = handles.recons;
recons = recons.*(recons>0);
handles.recons = recons;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 



function direccion_Callback(hObject, eventdata, handles)
% hObject    handle to direccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.direccion = get(hObject,'String');
if ischar(handles.direccion)
addpath handles.direccion
end
guidata(hObject, handles); 


% Hints: get(hObject,'String') returns contents of direccion as text
%        str2double(get(hObject,'String')) returns contents of direccion as a double


% --- Executes during object creation, after setting all properties.
function direccion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direccion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nombre_Callback(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.nombre = get(hObject,'String');
guidata(hObject, handles); 


% Hints: get(hObject,'String') returns contents of nombre as text
%        str2double(get(hObject,'String')) returns contents of nombre as a double


% --- Executes during object creation, after setting all properties.
function nombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Guardar.
function Guardar_Callback(hObject, eventdata, handles)
% hObject    handle to Guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recons = handles.recons;
if ischar(handles.direccion) && ischar(handles.nombre)
savefile = [handles.direccion,'\',handles.nombre,'.mat'];
else
    if ischar(handles.nombre)
    savefile = [handles.nombre,'.mat'];
    else
        savefile = 'reconstruccion.mat';
    end
end
save(savefile,'recons')
guidata(hObject, handles); 


% --- Executes on button press in filtro.
function filtro_Callback(hObject, eventdata, handles)
recons = handles.recons;

recons = medfilt2(recons,[handles.fil handles.fil]);
handles.recons = recons;
n=handles.n;
f=1:n:size(recons,1); c=1:n:size(recons,2);
axes(handles.grande)
mesh(c,f,flipud(recons(f,c)));
guidata(hObject, handles); 




function fil_Callback(hObject, eventdata, handles)
% hObject    handle to fil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fil =  str2double(get(hObject,'String'));
guidata(hObject, handles); 


% Hints: get(hObject,'String') returns contents of fil as text
%        str2double(get(hObject,'String')) returns contents of fil as a double


% --- Executes during object creation, after setting all properties.
function fil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function hotcolors_ClickedCallback(hObject, eventdata, handles)
colormap hot

% --------------------------------------------------------------------
function gray_ClickedCallback(hObject, eventdata, handles)
colormap gray

% --------------------------------------------------------------------
function jet_ClickedCallback(hObject, eventdata, handles)
colormap jet
