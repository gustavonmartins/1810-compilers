picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen
  %tests late-binding and direct binding. Shame the exercise specification is not clear
  r <- 100;
  esta:=draw(ellipse((100,300),r,90,45,90)); 
	
	setcolor(1,0,0);
  esta;
  
  r <- 150;
  setcolor(0,1,0);
  edyn;
  
  r <- 200;
  setcolor(0,0,1);
  esta;
  
  setcolor(0,0,1);
  

  
end
