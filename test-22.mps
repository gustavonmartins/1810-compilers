

picture "my-PSBeispiel"

var p1 : Path;
var p2: Path;


start               % Beginner mit Zeichenansweisungen

setfont("Arial",20);
setlinewidth(2);

draw(concat(
string2path((300,300),"my string")
,
arc((100,200),70,0,45)
));							%pass
  
end
