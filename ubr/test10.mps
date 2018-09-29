
% Fehler: Zuweisung an readonly-Variable 
picture "defined"
var x : Int;
var y : Int;
var z : Int;
start
  z := 1;
  for x := 0 to 23*6 step 4 do
     y := x + 1;
     x := 3 * x;
  done;
end
