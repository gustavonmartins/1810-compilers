digraph {
	
	node [shape=record];
	edge [len=2];
	S0[label="
	S'-\> .S	,$ \l
S	-\>.Xa	,$ \l
X	-\>.Xb	,a,b \l
	-\>.bYa	,a,b"];
	S1[label="{a|v|c}"];
	
    S0-> S1[label="S"];
    0 -> 2[label="X"];
    0 -> 3[label="b"];
    
    2 -> 4[label="a"];
    2 -> 5[label="b"];
    3 -> 6[label="Y"];
    3 -> 7[label="a"];
    
    6 -> 8[label="a"];
    7 -> 9[label="X"];
    7 -> 10[label="b"];
    
    9 -> 11[label="c"];
    9 -> 12[label="Z"];
    9 -> 13[label="b"];
    10 -> 14[label="Y"];
    10 -> 7[label="a"];
    
    11 -> 15[label="c"];
    14 -> 16[label="a"];
    
}
