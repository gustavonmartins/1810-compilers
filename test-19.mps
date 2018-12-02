picture "my-PSBeispiel"

var x : Num;                  %pass
var z : Num;                  %pass
var p : Point;                %pass
var p2 : Point;               %pass
var pt : Path;                %pass


start             

x:=2;
z:=10;
p<-(1,1);                     %pass
p<-(x,x);                     %pass
p:=(x,x);                     %pass
p:=(y,y);                     %fail, not declared
p2<-p1;                       %fail, not declared
p2:=p1;                       %fail, not declared
p2<-2;                        %fail, incompatible type
p2:=2;                        %fail, incompatible type
p2<-x;                        %fail, incompatible type
p2:=x;                        %fail, incompatible type
p2<-p;                        %pass
p2:=p;                        %pass
pt<-<<p,p>>;                  %pass
pt<-<<(1,1),p>>;              %pass
pt<-<<(1,1),x>>;              %fail, incompatible
pt:=<<p,p>>;                  %pass
pt:=<<(1,1),p>>;              %pass
pt:=<<(1,1),x>>;              %fail, incompatible


end
