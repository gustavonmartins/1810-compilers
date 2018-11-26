picture "my-PSBeispiel"

var x : Num;
var y : Num;
var z : Num;
var p : Path;
var black : Term;
start               % Beginner mit Zeichenansweisungen

setcolor(r,g,b);
setdrawstyle(s,e);
setfont(font,s);
setlinewidth(w);

p := <<p1,p2>>;

arc(p,r,alpha,beta);
ellipse(p,r1,r2,alpha,beta);
plot(x,y,n,min,max,(v,3*v));
string2path(p,s);
concat(p,q);
union(p,q);
scaletobox(x,y,p);
draw(p);
fill(p);
num2string(n);
write(p,s);
write(s);
rotate(alpha,t);
scale(x,y,t);
translate(x,y,t);
clip(p,t);

end
