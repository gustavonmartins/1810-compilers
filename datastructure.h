#include <iostream>
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
	PotentialValue(const std::string i_string){_string=i_string;}
	PotentialValue(const int i_int){_int=i_int;}
	PotentialValue(const double i_double){_double=i_double;}
	
	double getDouble()					{return _double;}
	int getInt()								{return _int;}
	std::string getString()			{return _string;}

	ComplexNode* eval(){}
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
  Value(std::string _string){val_string=_string;	}
	Value(double _double){val_num=_double;					}
	Value(int _int){val_int=_int;										}
	  
  std::string getString()	{return val_string;}
  double getDouble()			{return val_num;}
  int getInt()						{return val_int;}

	ComplexNode* eval(){}
};
