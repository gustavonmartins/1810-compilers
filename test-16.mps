picture "my-PSBeispiel"

var x : Num;
var y : Num;
var z : Num;
var p : Path;
var black : Term;
start               % Beginner mit Zeichenansweisungen

x := 3;
y <- x;     % variable y besitzt späte Bindung!
z := x;
x:= 5;

write(100,"hi"); 																			%type error, not a  point
write((100,100),3); 																	%type error, not a  string
write(3);																							%type error, not a string
setfont(3,10);																				%type error, not a string
string2path((200,300),3);															%type error, not a strint
string2path("(200,300)",3);														%type error, not a point
num2string(1000);																			%pass
setfont(num2string(1000),20);													%pass
draw(3);																							%type error, not a path									
fill(3);																							%type error, not a path
draw(<<(1,1),(3,3)>>);																%pass
fill(<<(1,1),(3,3)>>);																%pass
p:=<<(1,1),(3,3)>>				;														%pass
p:=<<(1.1,1.1),(3.3,3.3)>>;														%pass
p:=<<("hi",1.1),(3.3,3.3)>>	;													%type error, not int or num
setcolor(1,0.9,1);																		%pass
setcolor("hi",(3,3),<<(3.3),(4.4)>>);									%type error, not int or num
setdrawstyle(3,4);																		%pass
setdrawstyle(3.1,4);																	% error, not int
setfont("Arial",10);																	%pass
setfont("Arial",10.5);																%pass
setfont("Arial","ten");																%error, not int or num
setlinewidth(10);																			%pass
setlinewidth(10.3);																		%pass	
setlinewidth("ten");																	%error, not int or num
arc((10,10),40.3,0,45);																%pass
arc("hi",(10,10),"zero",45);													%error, not point, not int or num, not int or num
ellipse((10,10),40.3,80,0,45);												%pass
ellipse("hi",(10,10),"zero",<<(10,20),(30,40)>>,45);	%error, not point, not int or num, not int or num
num2string(3);																				%pass
num2string(3.5);																			%pass
num2string((2,2));																		%error, not int or num
%translate(20,30,draw(<<(10,20),(30,40)>>)); 					%pass																							%check this
%translate(20.2,30.2,draw(<<(10,20),(30,40)>>)); 			%pass																							%check this
translate("twenty",30.2,draw(<<(10,20),(30,40)>>)); 	%error, not int or num
%rotate(20,draw(<<(10,20),(30,40)>>)); 								%pass																							%check this
%rotate(20.2,draw(<<(10,20),(30,40)>>)); 							%pass																							%check this
rotate("twenty",draw(<<(10,20),(30,40)>>)); 					%error, not int or num
%scale(20,2,draw(<<(10,20),(30,40)>>)); 								%pass																						%check this
%scale(20.2,5,draw(<<(10,20),(30,40)>>)); 							%pass																						%check this
scale("twenty",5,draw(<<(10,20),(30,40)>>)); 					%error, not int or num
draw(arc((100,200),50,0,45));													%pass
draw(<<(100,200),(150,230),(345,123)>>);							%pass
draw(ellipse((100,200),50,70,0,45));									%pass
draw(string2path((100,200),"my string"));							%pass
translate(100,100,{draw(arc((100,200),50,0,45));});		%pass



end
