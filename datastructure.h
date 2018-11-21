#include <iostream>
#include <vector>

class ComplexNode  {
	std::string code;
	
	public:
	ComplexNode()=default;
	ComplexNode(char* _code){code.assign(_code);}
	ComplexNode(std::string _code){code=_code;}
	ComplexNode(ComplexNode*& child){code=child->getCode();}
	ComplexNode* printCode(){std::cout<<code<<std::endl;return this;}
	ComplexNode* setPoint(std::string x, std::string y){code=x+" "+y;return this;}
	ComplexNode* setString(std::string inp){code = "("+inp.substr(1, inp.size() - 2)+")";return this;}
	
	ComplexNode* setCode(std::string _code){code=_code; return this;}
	std::string getCode(){return code;}
	ComplexNode* setcolor(ComplexNode*& r,ComplexNode*& g,ComplexNode*& b){
		std::string a1, a2, a3, a4, a5, a6;
		a1=r->getCode();
		a2=g->getCode();
		a3=b->getCode();
		code=a1+" "+a2+" "+a3+" setrgbcolor";
		
		return this;
		}
		ComplexNode* setfont(ComplexNode*& font,ComplexNode*& s){
			std::string a1, a2, a3, a4, a5, a6;
			a1=font->getCode();
			a2 = s->getCode();
			code="/"+a1+" findfont "+a2+" scalefont setfont";
			
			return this;
			}
			
		ComplexNode* setlinewidth(ComplexNode*& w){
			std::string a1, a2, a3, a4, a5, a6;
			  a1=w->getCode();
			  code=a1+" setlinewidth";
			  
			  return this;
			}
		
		ComplexNode* setdrawstyle(ComplexNode*& s, ComplexNode*& e){
			std::string a1, a2, a3, a4, a5, a6;
			  a1=s->getCode();
			  a2=e->getCode();
			  code="["+a1+" "+a2+"] 0 setdash";
			  
			  return this;
			}
			
		ComplexNode* arc(ComplexNode*& p, ComplexNode*& r, ComplexNode*& alpha, ComplexNode*& beta){
			std::string a1, a2, a3, a4, a5, a6;
			std::string xy;
			xy=p->getCode();

			a3=r->getCode();
			a4=alpha->getCode();
			a5=beta->getCode();
			code="newpath "+xy+" "+a3+" "+a4+" "+a5+" arc";
			
			return this;
			}
			
		ComplexNode* ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta){
			std::string a1, a2, a3, a4, a5, a6;
			std::string xy;
			xy=p->getCode();

			a3=r1->getCode();
			a4=r2->getCode();
			a5=alpha->getCode();
			a6=beta->getCode();
			code="newpath /savematrix matrix currentmatrix def "+xy+" translate "+a3+" "+a4+" scale 0 0 1 "+a5+" "+a6+" arc savematrix setmatrix";
			
			return this;
			}
		
		ComplexNode* string2path(ComplexNode*& p, ComplexNode*& s){
			std::string a1, a2, a3, a4, a5, a6;
			std::string xy;
			xy=p->getCode();
			a3=s->getCode();
			
			code="newpath "+xy+" moveto "+a3+" true charpath";
			//std::cout<<"Code written: "<<code<<std::endl;
			
			return this;
			}
			
			ComplexNode* write(ComplexNode*& p, ComplexNode*& s){
			std::string a1, a2, a3, a4, a5, a6;
			std::string xy;
			xy=p->getCode();
			a3=s->getCode();

			code="newpath "+xy+" moveto "+a3+" show";

			return this;
			}

			ComplexNode* write(ComplexNode*& s){
			std::string a1, a2, a3, a4, a5, a6;
			a1=s->getCode();
			
			code=a1+" show";
			
			return this;
			}
			
			ComplexNode* num2string(ComplexNode*& n){
			std::string a1, a2, a3, a4, a5, a6;
			a1=n->getCode();
			
			code=a1+" 20 string cvs";
			
			return this;
			}
		
		ComplexNode* draw(ComplexNode*& p){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getCode();
			//std::cout<<"test: "<<a1<<std::endl;
			code=a1+" stroke";
			
			return this;
			}
		
		ComplexNode* fill(ComplexNode*& p){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getCode();
			code=a1+" closepath fill";
			
			return this;
			}
			
		ComplexNode* latebinding(ComplexNode*& lhs, ComplexNode*& rhs){
			  std::string a1,dummy, a2, a3, a4, a5, a6;
			  a1=lhs->getCode();
			  a2=rhs->getCode();
			  
			  
			  //std::cout<<"a1 is: "<<a1<<std::endl;
			  //std::cout<<"a2 is: "<<a2<<std::endl;
			  code="/"+a1+" { "+a2+" } def";
			  
			  return this;
			}
			
		ComplexNode* earlybinding(ComplexNode*& lhs, ComplexNode*& rhs){
			  std::string a1,dummy, a2, a3, a4, a5, a6;
			  a1=lhs->getCode();
			  a2=rhs->getCode();
			  
			  
			  //std::cout<<"a1 is: "<<a1<<std::endl;
			  //std::cout<<"a2 is: "<<a2<<std::endl;
			  code="/"+a1+" { "+a2+" } bind def";
			  
			  return this;
			}
			
		ComplexNode* binop(ComplexNode*& left, ComplexNode*& right, std::string op){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			
			if ("random"!=op){
				code=a1+" "+a2+" "+op;
				}
			else{
				code="rand 2 31 exp 1 sub div cvr "+a2+" "+a1+" sub cvr mul cvr "+a1+" add cvr";
			}
			
			
			return this;
			}
			
			ComplexNode* unop(ComplexNode*& left, std::string op){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			
			code=a1+" "+op;
			
			return this;
			}
			
			ComplexNode* forloop(ComplexNode*& id, ComplexNode*& start, ComplexNode*& end, ComplexNode*& inc, ComplexNode*& cmd){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=id->getCode();
			a2=start->getCode();
			a3=end->getCode();
			a4=inc->getCode();			
			a5=cmd->getCode();
			code=a2+" "+a4+" "+a3+" { /"+a1+" exch def "+a5+" } for";
			
			return this;
			}
			
			ComplexNode* append(ComplexNode*& extra){
				code=code+"\n"+extra->getCode();
				
				return this;
				}
			
			/*ComplexNode* pathoverpoints(ComplexNode*& rawlist){
				
				reallist=rawlist->getreallist();
				firstPoint=reallist->getNext()->getCode();
				code="new path "+currentPoint+" move to "
				for all others:
					currentPoint=reallist->getNext()->getCode();
					code=code+currentPoint+" lineto";
				
				return this;
				}
			
			std::vector<std::string> getreallist(){
			std::vector<std::string> output;
			
			
			
			return output;	
				}*/
};

