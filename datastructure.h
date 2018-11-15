#include <iostream>
#include <vector>
class ComplexNode {
	protected:
	std::string _code;
	
  public:
  virtual ComplexNode*  eval()=0;
};

class PotentialValue : public ComplexNode {
	std::string	_string;
	int 				_int;
	double 			_double;
	
	public:
	PotentialValue* setString(const std::string i_string){_string=i_string;	return this;}
	PotentialValue* setInt(const int i_int){_int=i_int;									return this;}
	PotentialValue* setDouble(const double i_double){_double=i_double;			return this;}
	
	double getDouble()					{return _double;}
	int getInt()								{return _int;}
	std::string getString()			{return _string;}

	ComplexNode* eval(){}
};

class FCall : public ComplexNode {
	std::vector<ComplexNode*> fvector;
	
	public:
	FCall* addFunc(ComplexNode* func){fvector.push_back(func);}
	
	ComplexNode* eval(){
		  for(ComplexNode* i : fvector){
				  i->eval();
				}
		}
		
};

class SetColor : public ComplexNode {
	double r, g, b;
	
	public:
	SetColor(PotentialValue* r,PotentialValue* g,PotentialValue* b){
		  this->r=r->getDouble();
		  this->g=g->getDouble();
		  this->b=b->getDouble();
		}

	ComplexNode* eval(){
		  std::cout<<r<<" "<<g<<" "<< b<<" setrgbcolor";
		}
};


class Value : public ComplexNode {
	std::string val_string;
  double val_num;
  int val_int;
  
  public:
  Value* setString(std::string _string){val_string=_string;	return this;}
	Value* setDouble(double _double){val_num=_double;				;	return this;}
	Value* setInt(int _int){val_int=_int;													; return this;}
	  
  std::string getString()	{return val_string;}
  double getDouble()			{return val_num;}
  int getInt()						{return val_int;}

	ComplexNode* eval(){}
};
