picture "stackoverflow"

var sum : Num;
var i : Num;

start

setfont("Times", 20);
sum := 0;
for i := 0 to 100 step 1 do
   sum := sum + i;
done;

write( (100,100) , num2string(sum));

end
