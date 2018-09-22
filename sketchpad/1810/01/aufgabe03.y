%token PICTURE IDENT START END
%token VALUE STATEMENT
%token TYPE VAR

%%

program : PICTURE IDENT declarations START commands END
        ;

declarations  : %empty
              | declarations declaration 
              ;

declaration   : VAR IDENT ':' TYPE ';'
              ;

commands      : %empty
              | commands command
              ;

command       : assign
              | STATEMENT
              ;

assign        : IDENT ":=" VALUE ';'
              | IDENT "<-" '{' commands '}' ';'
              ;
