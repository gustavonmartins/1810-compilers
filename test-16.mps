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

write(100,"hi"); 					%type error, not a  point
write((100,100),3); 			%type error, not a  string
write(3);									%type error, not a string
setfont(3,10);						%type error, not a string
string2path((200,300),3);	%type error, not a strint
num2string(1000);
setfont(num2string(1000),20);						%pass
end
