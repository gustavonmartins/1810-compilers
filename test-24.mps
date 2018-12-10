

picture "my-PSBeispiel"

var p1 : Path;
var t : Num;


start               % Beginner mit Zeichenansweisungen

setfont("Arial",20);
setlinewidth(2);

p1:=plot(200,100,200,0,3*360,(t,100*sin(t)+t*t/10000));
draw(p1);


  
end
