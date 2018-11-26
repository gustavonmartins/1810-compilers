picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen


	p:=(100,200);
  %polygon<-draw(<<p,(250,400),(509,600),(320,80),(90,100)>>);
  
  q:=(200,200);
  %kreis<-{};
  
  translate(111,222,{draw(<<p,(250,400),(509,600),(320,80),(90,100)>>);setcolor(1,0,0);fill(arc(q,50,0,360));});
  %kreis;
  setcolor(0,0,1);
  %polygon;
  
end

