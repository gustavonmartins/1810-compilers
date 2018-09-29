
% Diese Datei ist (nur) syntaktisch korrekt.
picture "correct"
  var x : Num;
  var x : Int;
  var x : String;
  var x : Point;
  var y : Path;
  var y : Term;
start

  p := (10 ,10);
  p2 <- <<p , (80, 80) , (90, 10) , p, x , y>>;
  x <- x + 1; 
  setcolor( 1000, 60 + 6 - 28 mod 7, V);
  setdrawstyle(a, random(10,20));
  setfont("Times", 27 + 6);
  setlinewidth(O);
  b := arc(p,r,alpha,beta);
  u := ellipse((19,8) , random(10,20), (18 * 9) , exp(2,7) , 9 );


  p <- concat( << (10,10), (20,20) >>,  ellipse(a,b,c,c,a) );
  f <- string2path(a," Das ist eine String ");
  l := union(x,y);
  j := scaletobox(90, exp(2,9),string2path((random(90,8),9),""));
  
  draw(ellipse(p,r1,r2,alpha,beta));

  fill(string2path(p,"MyPS"));

  write( (100,90.7) , num2string(sin(3*x) + 10) );

  write("<-");
  
  rotate(89/6 , { draw(b); } );
  rotate(-7.0, X);
  clip(O,scale(0.5, 7, translate(100,-1 * random(3,90),X)));

  for v := 10 to random(40,200) step exp(2,2) do
		draw(ellipse(p,r1,r2,alpha,beta));
		fill(string2path(p,"MyPS"));
		write((100,90.7),num2string(sin(3*x) + 10));
		write("<-");
		rotate(89/6 , { draw(b); } );
		rotate(-7.0, X);
		clip(O,scale(0.5, 7, translate(100,-1 * random(3,90),X)));
  done;

end
