picture "my-PSBeispiel"

var x : Num;                  %pass
var z : Num;                  %pass
var p : Point;                %pass
var p2 : Point;               %pass
var pt : Path;                %pass


start             

random(1,500);                %pass
exp(2,5);                     %pass
5+3;                          %pass
5+3.2;                        %pass
5.2+3;                        %pass
5-3;                          %pass
5-3.2;                        %pass
5.2-3;                        %pass
5*3;                          %pass
5*3.2;                        %pass
5.2*3;                        %pass
5/3;                          %pass
5/3.2;                        %pass
5.2/3;                        %pass
5 mod "3";                    %failt, wrong type
"5" mod "3";                  %failt, wrong type
5 mod 3;                      %pass
5 mod 3.2;                    %fail, not int
5.2 mod 3;                    %fail, not int
random(1,"400");              %fail, wrong type
random("1",400);              %fail, wrong type
exp(2+2,5);                   %pass
exp(-2+3,5);                  %pass
exp(-2,5);                    %pass
exp((-2),5);                  %pass

end
