a-03: aufgabe03.y aufgabe03.l
			bison -d -v aufgabe03.y
			flex -o aufgabe03.lex.c aufgabe03.l
			gcc -flto -o $@ aufgabe03.lex.c aufgabe03.tab.c -lm
