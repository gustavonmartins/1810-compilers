picture "my-PSBeispiel"

var x : Num;                  %pass
var z : Num;                  %pass
var p : Point;                %pass
var p2 : Point;               %pass


start             

x:=2;
z:=10;
p<-(1,1);                     %pass
p<-(x,x);                     %pass
p<-(y,y);                     %fail. undeclared y
p<-(z,z);                     %pass
p1<-p;                        %fail. undeclared p1
p2<-p;                        %pass




end
