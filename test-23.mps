

picture "my-PSBeispiel"

var p1 : Path;
var p2 : Path;


start               % Beginner mit Zeichenansweisungen

setfont("Arial",20);
setlinewidth(2);

p1<-<<(100,100),(200,200),(200,300)>> ;
p2:=arc((300,300),100,0,45);


draw(p1);
draw(scaletobox(50,50,p1));
draw(p2);
  
end
