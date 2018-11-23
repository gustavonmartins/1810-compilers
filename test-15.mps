picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen

	setfont("Courier",20);
	p:=(100,200);
  polygon<-draw(<<p,(250,400),(509,600),(320,80),(90,100)>>);
  polrot<-rotate(10,polygon);
  
  q:=(400,500);
  kreis<-{setcolor(1,0,0);fill(arc(q,70,0,360));};
  
  %;
  draw(string2path((200,200),"0 graus"));
  clip(<<(300,500),(500,500),(500,700),(300,700),(300,500)>>,polrot);
  rotate(45,draw(string2path((200,200),"45 graus")));
  
  setcolor(0,0,1);
  clip(<<(300,500),(500,500),(500,700),(300,700),(300,500)>>,{polygon;polrot;kreis;});
  
  scale(1,3,draw(write((10,10),"Escala")));
  
end
