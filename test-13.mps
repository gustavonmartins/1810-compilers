picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen


	p:=(100,200);
  draw(<<p,(250,400),(509,600),(320,80),(90,100)>>);
  
  p:=(200,200);
  kreis<-{setcolor(1,0,0);fill(arc(p,50,0,360));};
  
  kreis;
  
end

