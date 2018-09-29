
% Fehler: Typkonflikt 
picture "typetest1"
var x : Int;
var y : String;
start
   x := 3;
   y := "test";
   x := 3+sin(4.0 * y);
end
