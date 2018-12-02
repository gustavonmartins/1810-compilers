picture "my-PSBeispiel"

var x : Num;                  %pass
var x : String;               %error: already declared
var z : Num;                  %pass

start             

x:=3;                         %pass
y:=3;                         %fail
x<-3;                         %pass
y<-3;                         %fail
x:=x;                         %pass
y:=x;                         %fail
x<-x;                         %pass
y<-x;                         %fail
x:=y;                         %fail
y:=y;                         %fail
x<-y;                         %fail
y<-y;                         %fail
x:=3;                         %pass
y:=3;                         %fail
p:=(1,1);                     %fail
p<-(1,1);                     %fail
x:=(1,1);                     %pass
x<-(1,1);                     %pass
p:=(1,1);                     %fail
p<-(1,1);                     %fail
x:=(1,1);                     %pass
x<-(1,1);                     %pass
q;                            %fail
x;                            %pass

end
