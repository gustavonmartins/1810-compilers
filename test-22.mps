

picture "my-PSBeispiel"

var p1 : Path;
var p2: Path;
var p3: Path;

start               % Beginner mit Zeichenansweisungen

setfont("Arial",20);
setlinewidth(2);

p1<-arc((100,200),70,0,45);
p2<-<<(100,100),(200,200),(200,300)>> ;
p3<-string2path((500,500),"cole cara") ;

setlinewidth(2);

draw(union(
p2
,
concat(p1,p3)
));							%pass
  
end
