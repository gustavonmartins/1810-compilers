%token NOISE DECLARATION NONLOOPED OPEN CLOSE

%%

SOURCE          :       NOISES EXECS NOISES
                ;

EXECS           :       EXEC 		
                |       EXECS NOISES EXEC
                ;

EXEC            :       NONLOOPED
                |       LOOPED
                ;

LOOPED	        :       OPEN NOISES EXECS NOISES CLOSE
                ;

NOISES          :       NOISE
                |       NOISES NOISE
                ;
/*
NONLOOPED	:	x.execute(...);
		|	x.executeQuery(...);
		|	y=x.execute();
		|	y=x.executeQuery(...);
		|	f(...,x,...);
		|	y=f(...,x,...);
		;
*/

/*separate waste inside execs missing
assign responsibility to detect wastes

Try will close before waste of source */
