picture "myeps-test"

var i: Num;
var r : Num;

start  % Beginne mit Zeichenanweisungen
  
  setfont("Helvetica", 20);
  setcolor(0,0,1); % blue
  
  setdrawstyle(1,0); % solid lines
%  draw( ((10,10), (100,100), (100,10)) ); 



  for i := 0 to 100 step 10 do
    for r := 20 to 100 step 10 do
      draw( << (i * 10, r * 10),(i * 10 + 100 ,r * 10 )>> );
      draw( << (i * 10, r * 10) , (i * 10 , r * 10 + 100)>>);
      write( (i * 10 , r * 10) , num2string ( i )  );
      write(" , ");
      write( num2string(r) );
    done;
  done; 
  

end
