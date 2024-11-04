function edit1_Callback(hObject, eventdata, handles)
% hObject :edit1对象的句柄（参见gcbo用法）
% eventdata:为了兼容MATLAB将来版本的保留接口
% handles:拥有句柄的全局变量，可以用来传输用户数据（参见 GUIDATA）
% get(hObject,'String')：返回edit1对象的内容为文本形式
% str2double(get(hObject,'String'))：将edit1对象的内容转化为双精度型
%以字符串的形式来存储数据文本框1的内容。如果字符串不是数字，则显示空白内容
input = str2num(get(hObject,'String')); 
%检查输入是否为空。如果为空，则默认显示为0
if (isempty(input))     
set(hObject,'String','0')
end
guidata(hObject, handles);
% --- pushbutton1：对象上执行单击动作
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject:pushbutton1对象的句柄（参见gcbo用法）
% eventdata:为了兼容MATLAB将来版本的保留接口
% handles:拥有句柄的全局变量，可以用来传输用户数据（参见 GUIDATA）
a = get(handles.edit1,'String');
b = get(handles.edit2,'String');
% a 和 b 是字符串类型，需要转换为数字类型的变量才能相加
total = str2num(a) + str2num(b);
c = num2str(total);
% 需要将运算结果转换回字符串类型然后加以显示
set(handles.text8,'String',c);
guidata(hObject, handles);
