picture "myPS-Wuerfel"
% Deklaration einiger Variablen

var sqp : Path;
var line1 : Path;
var line2 : Path;
var line3 : Path;
var line4 : Path;
var pfeil : Path;
var p: Path;

var txy : Term;
var tyz : Term;
var dLine : Term;
var dPfeil: Term;
var dAnnotate: Term;

var str : String;

var s: Num; 
var t: Num; 
var x0: Num;
var y0: Num;
var z0: Num;
var zs: Num;
var bs: Num;
var b0: Num;
var r0: Num;
var alpha: Num;
var Pfeil: Num;

start  % Beginne mit Zeichenanweisungen

  %startPS 100 100 translate endPS 

  s := 200;
  % das Einheitsquadrat
  sqp := <<(0,0), (0,1), (1,1), (1,0), (0,0)>>;
  
  % die Verbindungslinien zwischen sqp und einem in den
  % Punkt (0.5, 0.5) verschobenen sqp.
  line1 := <<(0,0), (0.5, 0.5)>>;
  line2 := <<(0,1), (0.5, 1.5)>>;
  line3 := <<(1,1), (1.5, 1.5)>>;
  line4 := <<(1,0), (1.5, 0.5)>>;
 
  % eine Pfeildefinition
  alpha := 30;     % Winkel der Pfeilspitzen
  x0 := 0.1;       % Größe der Pfeilspitze im Verhältnis
                   % zur Länge
  
  y0 := x0 * sin(alpha);   
  pfeil := <<(1 - x0, y0), (1,0), (0,0), (1,0), (1 - x0, 0 - y0)>>;
 
 
  % Trapez in der x-y Ebene. 
  % b0: offset
  % bs: Länge, bo + bs <= 1
  txy <-  { setlinewidth(1/s);
            scale(s, s, draw(
            << (0 + b0 * 0.5, y0), 
               (1 + b0 * 0.5, y0), 
               (1 + 0.5 * (bs + b0), y0 + 0.5 * bs), 
               (0.5 * (bs + b0), y0 + 0.5 * bs), 
               (0 + b0 * 0.5, y0) >> )); 
           };

  % Trapez in der y-z Ebene
  tyz <- { setlinewidth(1/s);
            scale(s, s, draw(
            << (0 + x0 + b0 * 0.5, 0 + b0 * 0.5 + z0 * 1), 
               (0.5 * (b0 + bs) + x0, (b0 + bs) * 0.5 + z0 * 1), 
               (0.5 * (b0 + bs) + x0, (z0 + zs) * 1 + (b0 + bs) * 0.5), 
               (0 + x0 + b0 *0.5, (z0 + zs) * 1 + b0 * 0.5), 
               (0 + x0 + b0 * 0.5, 0 + b0 * 0.5 + z0 * 1) >> ));
          }; 


  p := line1; 
  % Die obige Anweisung ist notwendig umd die Art der Bindung
  % für die folgenden Definitionen festzulegen.
 
  % Zeichne den Pfad p mit Linienstärke t und
  % Skalierungsfaktor s.
  dLine <- { setlinewidth(t);
                scale(s, s, draw(p)); };

  % Makro zum Zeichnen eines Pfeils
  % (x0, y0) : Startpunkt
  % r0 : Rotationswinkel
  % s : Skalierungsfaktor
  dPfeil <- {  translate(x0, y0, rotate(r0, dLine)); 
               translate(x0, y0, write( (s * 1.1 * cos(r0), 
	                                 s * 1.1 * sin(r0)), str)); 
	     }; 
  

  % Zeichne die Koordinatenachsen
  setfont("Times-Italic", 10);
  x0 := 10;
  y0 := 260;
  s := 30;
  t := 1/100;
  p := pfeil;
  r0 := 0;  str := "x"; dPfeil;
  r0 := 45; str := "y"; dPfeil;
  r0 := 90; str := "z"; dPfeil;


  % Zeichne den Würfel
  s := 200;
  t := 2/s;
  p := sqp; dLine;
  translate(s/2, s/2, dLine );
  p := line1; dLine;
  p := line2; dLine;
  p := line3; dLine;
  p := line4; dLine;

  % Zerteile in der x-z Ebene
  t := 1/s;
  setcolor(1,0,0);
  p := sqp;
  translate(s/8, s/8, dLine );

  x0 := s + s/8;
  y0 := s/3 + s/8;
  r0 := -15; 
  str := "F";
  
  setfont("Times-Italic", 12);
  dAnnotate <- { setdrawstyle(1, 0);
                 s := 90; t := 1/s;
                 p := pfeil; dPfeil;
                 s := 200; t := 1/s;
	        };
  dAnnotate;		
  
  setdrawstyle(4/s, 2/s);
  setcolor(0,0.5,0);
  bs := 1/4;
  b0 := 0;
  y0 := 0.2;
  txy;

  x0 := s + s/16;
  y0 := s * 0.2 + s/16;
  r0 := -15; 
  str := "G";
  dAnnotate;		


  setdrawstyle(20/s, 10/s);
  bs := 3/4;
  b0 := 1/4;
  y0 := 0.6;
  txy;

  x0 := 1.3 * s;
  y0 := 0.75 * s;
  r0 := -15; 
  str := "H";
  dAnnotate;	

  setdrawstyle(10/s, 5/s);
  setcolor(0,0,1);
  bs := 3/4;
  b0 := 1/4;
  x0 := 1/4;
  z0 := 0;
  zs := 0.5;
  tyz;

  x0 := 149 / 200 * s;
  y0 := 241 / 200 * s;
  r0 := 55; 
  str := "J";
  dAnnotate;	

  setdrawstyle(10/s, 5/s);
  x0 := 1/4;
  z0 := 0.5;
  zs := 0.5;
  tyz;

  x0 := 149 / 200 * s;
  y0 := 168 / 200 * s;
  r0 := 60;
  str := "K";
  dAnnotate;	


end
