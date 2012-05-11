#ifndef MOVE_HEADER
#define MOVE_HEADER

#include "Position.h"

#include <string>

class Chessman;

class Move {
private:
	Chessman* chessman;
	Chessman* killed;
	Position position;
public:
	Move(Chessman* aChessman, Position aPosition) : chessman(aChessman), position(aPosition), killed(0) { }
	Move(Chessman* aChessman, Position aPosition, Chessman* aKilled) : chessman(aChessman), position(aPosition), killed(aKilled) { }
	Move execute();
	std::string toString();
	Position getPosition() {
		return position;
	}
};

#endif