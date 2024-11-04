function ex17_6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ex17_6 (see VARARGIN)
handles.peaks=peaks(35);
handles.membrane=membrane;
[x,y]=meshgrid(-8:.5:8);
r=sqrt(x.^2+y.^2)+eps;
z=sin(r)./r;
handles.sinc=z;
handles.current_data=handles.peaks;
surf(handles.current_data);
% Choose default command line output for ex17_6
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
