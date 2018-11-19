picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen
  
  r <- 23;
  a <- 12;
  esta:=draw(arc((100,300),r*a,r-a,r+a)); 
  edyn<-draw(arc((100,300),r*a,r-a,r+a)); 
	
	setcolor(1,0,0);
  esta;
  
  r <- 30;
  a <- 13;
  setcolor(0,1,0);
  edyn;
  
  r <- 31;
  a <- 14;
  setcolor(0,0,1);
  esta;
  
  setcolor(0,0,1);
  

  
end
