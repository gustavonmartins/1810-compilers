

picture "my-PSBeispiel"

var p1 : Path;


start               % Beginner mit Zeichenansweisungen

setfont("Arial",20);
setlinewidth(2);

p1<-<<(100,100),(200,200),(200,300)>> ;


draw(p1);
draw(scaletobox(50,50,p1));

  
end
