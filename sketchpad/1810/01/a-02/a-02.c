#define TRUE 1

int gettoken(){
	int c;
	state = 0; start_state=0;
	while (TRUE){
		switch(state){
			case 11:
				c = nextchar();
				if isdigit(c)		state=12;
				else if issign(c)	state=13;
				else				state=next_diagram();
				break;
			
			case 12:
				c = nextchar();
				if c=='.'			state=14;
				else if isdigit(c)	state=12;
				else				state=next_diagram();
				break;
			
			case 13:
				c=nextchar();
				if isdigit(c)		state=12;
				else				state=next_diagram();
				break;
			
			case 14:
				c=nextchar();
				if isdigit(c)		state=15;
				else if c=='E'		state=17;
				else				state=16;
				break;
			
			case 15:
				c=nextchar();
				if isdigit(c)		state=15;
				else if c=='E'		state=17;
				else				state=16;
				break;
			
			case 16:
				return REAL;
				break;
			
			case 17:
				c=nextchar();
				if isdigit(c)		state=18;
				else if issign(c)	state=19;
				else				state=next_diagram();
				break;
				
			case 18;
				c=nextchar(c)
				if isdigit(c)		state=18;
				else				state=16;
				break;
				
			case 19:
				c=nextchar();
				if isdigit(c)		state=18;
				else				state=next_diagram();
		}
	}
}