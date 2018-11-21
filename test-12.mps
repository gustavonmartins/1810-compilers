picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen
  
  r := 100;
  esta:=draw(arc((100,300),r+a,0,a)); 
  edyn<-draw(arc((100,300),r,45,90)); 
	col:=setcolor(r,0,00);
	
	
	for r:=100 to 300 step 50 do
		for a:= 0 to 45 step 10 do
			esta;
		done;
			
	done;
	
	setfont("Arial",12);
	write((300,400),"write on pos");
	write("Write freely");
	write(num2string(3.14159));
  

  
end
