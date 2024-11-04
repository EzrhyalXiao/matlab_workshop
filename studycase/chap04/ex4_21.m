Array = 1:5;
String = '[Array*2; Array/2; 2.^Array]';
Outpute = eval(String)					%使用eval函数运行表达式
Outputf = feval(String)					%使用feval函数运行表达式
