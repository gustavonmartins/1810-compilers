picture "myeps-test"

var i : Num;

start  % Beginne mit Zeichenanweisungen
  
  setfont("Helvetica", 20);
  setcolor(0,0,1); % blue
  
  setdrawstyle(1,0); % solid lines
%  draw( ((10,10), (100,100), (100,10)) ); 



  for i := 0 to 400 step 22 do
     write((0,i), num2string( random(0, exp(2, 30)) ));
  done; 
  

end
