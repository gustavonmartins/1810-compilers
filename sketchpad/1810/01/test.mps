picture "example"
var kreis : Term;
var dreieck : Path;
var p : Point;

start

p := (10,10); 
kreis <- {setcolor(~1,0,0); fill(arc(p,50,0,360));};
dreieck := <<p, (10,100), (100,10), p>>;
end
