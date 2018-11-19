#include <iostream>
#include <vector>

class ComplexNode  {
	std::string code;
	std::pair<std::string,std::string> 	point;
	
	public:
	ComplexNode()=default;
	ComplexNode(char* _code){code.assign(_code);}
	ComplexNode(std::string _code){code=_code;}
	ComplexNode(ComplexNode*& child){code=child->getCode();}
	ComplexNode* printCode(){std::cout<<code<<std::endl;return this;}
	std::pair<std::string,std::string> getPoint()	{return point;}
	ComplexNode* setPoint(std::string x, std::string y){point.first=x;point.second=y; return this;}
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
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r->getCode();
			a4=alpha->getCode();
			a5=beta->getCode();
			code="newpath "+a1+" "+a2+" "+a3+" "+a4+" "+a5+" arc";
			
			return this;
			}
			
		ComplexNode* ellipse(ComplexNode*& p, ComplexNode*& r1, ComplexNode*& r2, ComplexNode*& alpha, ComplexNode*& beta){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=r1->getCode();
			a4=r2->getCode();
			a5=alpha->getCode();
			a6=beta->getCode();
			code="newpath /savematrix matrix currentmatrix def "+a1+" "+a2+" translate "+a3+" "+a4+" scale 0 0 1 "+a5+" "+a6+" arc savematrix setmatrix";
			
			return this;
			}
		
		ComplexNode* string2path(ComplexNode*& p, ComplexNode*& s){
			std::string a1, a2, a3, a4, a5, a6;
			a1=p->getPoint().first;
			a2=p->getPoint().second;
			a3=s->getCode();
			
			code="newpath "+a1+" "+a2+" moveto "+a3+" true charpath";
			//std::cout<<"Code written: "<<code<<std::endl;
			
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
			
		ComplexNode* uminus(ComplexNode*& num){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=num->getCode();
			code=a1+" neg";
			
			return this;
			}
			
		ComplexNode* plus(ComplexNode*& left, ComplexNode*& right){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			code=a1+" "+a2+" add";
			
			return this;
			}
			
			ComplexNode* minus(ComplexNode*& left, ComplexNode*& right){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			code=a1+" "+a2+" sub";
			
			return this;
			}
			
			ComplexNode* mult(ComplexNode*& left, ComplexNode*& right){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			code=a1+" "+a2+" mul";
			
			return this;
			}
			
			ComplexNode* div(ComplexNode*& left, ComplexNode*& right){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			code=a1+" "+a2+" div";
			
			return this;
			}
			
			ComplexNode* mod(ComplexNode*& left, ComplexNode*& right){
			std::string a1,dummy, a2, a3, a4, a5, a6;
			a1=left->getCode();
			a2=right->getCode();
			code=a1+" "+a2+" mod";
			
			return this;
			}
};

