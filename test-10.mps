picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen


  for r := 10 to 100 step 5 do 
    for a := 2 to 20 step 5 do
    	draw(arc((100,300),r*a,r-a,r+a)); 
    done;
  done;
  
end
