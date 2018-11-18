a-03: aufgabe03.y aufgabe03.l datastructure.h
			bison -d -v aufgabe03.y
			flex -o aufgabe03.lex.c aufgabe03.l
			g++ -flto -o $@ aufgabe03.lex.c aufgabe03.tab.c -lm -Wall -g

clean:
			rm aufgabe03.lex.c aufgabe03.tab.c aufgabe03.tab.h
