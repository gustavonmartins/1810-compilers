picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen

	setfont("Courier",20);
	p:=(100,200);
  polygon<-draw(<<p,(250,400),(509,600),(320,80),(90,100)>>);
  
  q:=(200,200);
  kreis<-{setcolor(1,0,0);fill(arc(q,50,0,360));};
  
  rotate(10,polygon);
  draw(string2path((200,200),"0 graus"));
  rotate(45,draw(string2path((200,200),"45 graus")));
  kreis;
  setcolor(0,0,1);
  polygon;
  scale(1,3,draw(write((10,10),"Escala")));
  
end
