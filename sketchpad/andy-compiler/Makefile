ab:		Simple.l Simple.y ParserHelper.c ParserHelper.h CG.c CG.h SM.c SM.h ST.h ST.c
		bison -d Simple.y
		flex -o Simple.lex.c Simple.l
		clang -o $@ Simple.tab.c Simple.lex.c ParserHelper.c CG.c SM.c ST.c -lm
		rm Simple.tab.c Simple.tab.h Simple.lex.c

clean:	Simple.tab.c Simple.tab.h Simple.lex.c
		rm Simple.tab.c Simple.tab.h Simple.lex.c
