 str(1)={'第一个'};
	str(2)={'第二个'};
	str(3)={'第三个'};
	Hm_list=uicontrol('style','listbox','position',[200 250 80 100],'string',str, 'callback','listbox1_callback');
index_selected=get(Hm_list,'Value');
list=get(Hm_list,'String');
listnum=list{index_selected}
switch listnum
  case '第一个'
      msgbox('这是第一个对话框！','消息','non-modal');
  case '第二个'
      msgbox('这是第二个对话框！','消息','non-modal');
  case '第三个'
      msgbox('这是第三个对话框！','消息','non-modal');
  otherwise
      msgbox('未选中选项，请选择！','消息','non-modal');
end
