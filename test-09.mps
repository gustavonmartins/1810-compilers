picture "my-PSBeispiel"


start               % Beginner mit Zeichenansweisungen


zabur<-setfont("Arial",12);
pomano<-ellipse(1,2,3,4,5);
%q:="hi";
setcolor(0.9,0.5,0.5);
setfont("Arial",48);
setlinewidth(3);
setdrawstyle(6,3);
q<-"banco";
q;
draw(string2path((300,400),q));
draw(string2path((11,22),q));
draw(string2path(((11),22),q));
draw(string2path((11,(22)),q));
draw(string2path((11,22),(q)));
draw(string2path(((11),(22)),(q)));
draw(string2path(((+11),(22)),(q)));
draw(string2path((+(11),(22)),(q)));
draw(string2path((-10,22),q));
draw(string2path((-(10),22),q));
setfont("Arial",120);
setfont("Arial",10+20);
setfont("Arial",(10+20));
setfont("Arial",10+(20));
setfont("Arial",10+(-20));
ellipse((1,2),3,4,55,550);
ellipse((1,2),3,4,55,500+50);
5+3;
5-3;
5*3;
5 mod 2;
5--3;
5---3;
res<-5---3;
end


