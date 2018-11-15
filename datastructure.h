#include <iostream>
#include <vector>
class ComplexNode {
	std::vector<ComplexNode*> nodeVector;
	
	public:
	void addNode(ComplexNode* node){nodeVector.push_back(node);}
	
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

	void eval() {}
};

class SetColor : public ComplexNode {
	double _r, _g, _b;
	
	public:
	void init(PotentialValue* r,PotentialValue* g,PotentialValue* b){
		  _r=r->getDouble();
		  _g=g->getDouble();
		  _b=b->getDouble();
		  std::cout<<"inited setcolor\n";
		  std::cout<<_r<<" "<<_g<<" "<<_b<<" setrgbcolor 1\n";
		}

	void eval()  {
		  std::cout<<_r<<" "<<_g<<" "<< _b<<" setrgbcolor 2\n";
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

	void eval() {}
};
