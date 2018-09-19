%start program
%token cidnms_test
%token CONST IDENT NUMBER VAR PROCEDURE 
%token CALL BEGIN END IF THEN WHILE DO
%token ODD

%expect 0

%%
program : block '.'
        ;

// Block
block   : const_decls var_decls procedures statement
        ;

const_decls : %empty
            | CONST decls ';'
            ;
              
decls : IDENT '=' NUMBER
      | decls ',' IDENT '=' NUMBER
      ;

var_decls    : %empty
              | VAR var_decls_go ';'
              ;
              
var_decls_go  : IDENT
              | var_decls_go ',' IDENT
              ;

procedures    : %empty
              | procedures PROCEDURE IDENT ';' block ';'
              
// Statement
statement     : IDENT ":=" expression
              | CALL IDENT
              | BEGIN statement statements END
              | IF condition THEN statement
              | WHILE condition DO statement
              ;
              
statements    : %empty
              | statements ';' statement
              ;
              
//Condition
condition     : ODD expression
              | expression '=' expression
              | expression "!=" expression
              | expression '<' expression
              | expression '>' expression
              | expression "<=" expression
              | expression ">=" expression
              ;

// Expression
expression    : maybe_sign term maybe_termsign_loop
              ;
              
maybe_termsign_loop : %empty
                    | maybe_termsign_loop '+' term
                    | maybe_termsign_loop '-' term
                    ;

              
maybe_sign    : '+'
              | '-'
              | %empty
              ;
//Term              
term          : factor factorloop;
              ;
factorloop    : %empty
              | factorloop '*' factor
              | factorloop '/' factor
              ;

//Factor
factor        : IDENT
              | NUMBER
              | '(' expression ')'
              ;
%%
