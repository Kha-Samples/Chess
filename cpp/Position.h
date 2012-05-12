#ifndef POSITION_HEADER
#define POSITION_HEADER

#include <string>

class Position {
private:
	int x, y;
public:
	//initializeAt: aX And: aY
	//x_aX.
	//y_aY.
	Position(int aX, int aY) : x(aX), y(aY) { }

	//toString
	//|string|
	//string_String new.
	//string_(string , (x printString) , '-' , (y printString)).
	//^string! !
	std::string toString();

	//x
	//^x! !
	int getX() {
		return x;
	}

	//y
	//^y! !
	int getY() {
		return y;
	}
};

#endif