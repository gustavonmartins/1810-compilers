fb1-5:	fb1-5.l fb1-5.y
		bison -d fb1-5.y
		flex fb1-5.l
		cc -o $@ fb1-5.tab.c lex.yy.c -lfl -lm
		rm fb1-5.tab.c fb1-5.tab.h lex.yy.c

fb3-1:	fb3-1.l fb3-1.y fb3-1.h fb3-1main.c
		bison -d fb3-1.y
		flex -o fb3-1.lex.c fb3-1.l
		cc -o $@ fb3-1.tab.c fb3-1.lex.c fb3-1main.c
		rm fb3-1.tab.c fb3-1.lex.c fb3-1.tab.h
